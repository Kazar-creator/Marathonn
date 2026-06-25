<?php
    require_once 'DbConnector.php';
    session_start();

    

    $connection = new DbConnector('localhost', 'root', 'root', 'marathon');
    
    $id = $_GET['id'];
    if (!$id) { 
        header("Location: index.php"); 
        exit; 
    }

    $user = null;

if (isset($_SESSION['user_id'])) {
    $stmtUser = $connection->prepare("SELECT * FROM users WHERE id = :id");
    $stmtUser->execute([':id' => $_SESSION['user_id']]);
    $user = $stmtUser->fetch(PDO::FETCH_ASSOC);
}

    // SOLO media NON cancellati
    $stmt = $connection->prepare("SELECT * FROM media WHERE id = :id AND deleted_at IS NULL");
    $stmt->bindParam(':id', $id);
    $stmt->execute();
    $media = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$media) { 
        header("Location: index.php");
        exit; 
    }

    $stmtReviews = $connection->prepare("
        SELECT r.*, u.name FROM reviews r
        JOIN users u ON r.id_user = u.id
        WHERE r.id_media = :id
        ORDER BY r.id DESC
    ");
    $stmtReviews->execute([':id' => $id]);
    $reviews = $stmtReviews->fetchAll(PDO::FETCH_ASSOC);

    // Stato dell'utente loggato per questo media
    $userStatus = null;
    if (isset($_SESSION['user_id'])) {
        $stmtStatus = $connection->prepare("
            SELECT status FROM user_library
            WHERE id_user = :uid AND id_media = :mid
        ");
        $stmtStatus->execute([':uid' => $_SESSION['user_id'], ':mid' => $id]);
        $row = $stmtStatus->fetch(PDO::FETCH_ASSOC);
        if ($row) {
            $userStatus = $row['status'];
        }
    }

    // Controlla se l'utente ha già scritto una review per questo media
    $userAlreadyReviewed = false;
    if (isset($_SESSION['user_id'])) {
        $stmtCheck = $connection->prepare("
            SELECT id FROM reviews WHERE id_user = :uid AND id_media = :mid
        ");
        $stmtCheck->execute([':uid' => $_SESSION['user_id'], ':mid' => $id]);
        if ($stmtCheck->fetch()) {
            $userAlreadyReviewed = true;
        }
    }

    // Carica tutte le stagioni e episodi
    
?>

<html>
    <head>
        <meta content="width=device-width, initial-scale=1"/>
        <link rel="stylesheet" href="style.css">
        <title>MARATHON - Details</title>
        <style>
            .status-box {
                display: inline-block;
                margin-top: 20px;
                padding: 8px 18px;
                border-radius: 8px;
                font-size: 15px;
                font-weight: bold;
                border: 1px solid rgba(255,255,255,0.15);
            }
            .status-select {
                margin-top: 8px;
                background: #1a1a2e;
                color: #eaeaf0;
                border: 1px solid #3a3a5a;
                padding: 6px 12px;
                border-radius: 6px;
                font-size: 14px;
                cursor: pointer;
            }
            .review-form {
                margin-top: 30px;
                background: rgba(255,255,255,0.03);
                border: 1px solid #2a2a4a;
                border-radius: 10px;
                padding: 24px;
                max-width: 800px;
                margin-left: auto;
                margin-right: auto;
            }
            .review-form h3 {
                margin: 0 0 16px;
                color: #8ab4f8;
                font-size: 18px;
            }
            .review-form textarea {
                width: 100%;
                background: #1a1a2e;
                border: 1px solid #3a3a5a;
                border-radius: 6px;
                color: #eaeaf0;
                font-size: 14px;
                padding: 10px;
                resize: vertical;
                min-height: 100px;
                box-sizing: border-box;
                outline: none;
            }
            .review-form input[type=number] {
                background: #1a1a2e;
                border: 1px solid #3a3a5a;
                border-radius: 6px;
                color: #eaeaf0;
                font-size: 14px;
                padding: 8px 12px;
                width: 80px;
                outline: none;
                margin-top: 10px;
            }
            .review-form button {
                margin-top: 12px;
                background: #8ab4f8;
                color: #0f0f1a;
                border: none;
                border-radius: 6px;
                padding: 10px 24px;
                font-size: 14px;
                font-weight: bold;
                cursor: pointer;
            }
            .review-form button:hover {
                background: #aac8ff;
            }
            .already-reviewed {
                margin-top: 30px;
                padding: 14px 20px;
                background: rgba(255,255,255,0.03);
                border: 1px solid #2a2a4a;
                border-radius: 10px;
                color: #a0a0c0;
                font-style: italic;
                text-align: center;
                max-width: 800px;
                margin-left: auto;
                margin-right: auto;
            }
            .info-row {
                margin-top: 20px;
            }
            .info-label {
                color: #ff6b6b;
                font-weight: bold;
                margin-bottom: 8px;
            }
            .seasons-badge {
                display: inline-block;
                background: #2a2a4a;
                padding: 4px 12px;
                border-radius: 20px;
                font-size: 13px;
                margin-left: 10px;
            }
            
            /* Stili per episodi in fila orizzontale */
            .season-container {
                margin-bottom: 30px;
            }
            .season-title {
                color: #8ab4f8;
                font-size: 18px;
                margin-bottom: 15px;
                padding-bottom: 8px;
                border-bottom: 1px solid #2a2a4a;
            }
            .episodes-scroll {
                display: flex;
                overflow-x: auto;
                gap: 12px;
                padding: 10px 0 20px 0;
                scrollbar-width: thin;
            }
            .episodes-scroll::-webkit-scrollbar {
                height: 6px;
            }
            .episodes-scroll::-webkit-scrollbar-track {
                background: #1a1a2e;
                border-radius: 3px;
            }
            .episodes-scroll::-webkit-scrollbar-thumb {
                background: #3a3a5a;
                border-radius: 3px;
            }
            .episode-card {
                width: 140px;
                flex-shrink: 0;
                background: #1a1a2e;
                border-radius: 8px;
                overflow: hidden;
                border: 1px solid #2a2a4a;
                transition: transform 0.2s;
                text-decoration: none;
                color: inherit;
            }
            .episode-card:hover {
                transform: scale(1.02);
                border-color: #8ab4f8;
            }
            .episode-thumb {
                width: 100%;
                height: 78px;
                background: #2a2a4a;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 28px;
            }
            .episode-info {
                padding: 8px;
            }
            .episode-number {
                font-size: 11px;
                color: #8ab4f8;
            }
            .episode-title {
                font-size: 12px;
                font-weight: bold;
                margin: 4px 0;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }
            .episode-duration {
                font-size: 10px;
                color: #606080;
            }
            .section-divider {
                border: 1px solid gray;
                margin: 40px 0;
            }
            .review-section {
                padding: 0 80px 60px;
            }
            .reviews-container {
                margin-top: 40px;
            }
        </style>
        <title>MARATHON</title>
    </head>
    <body>
        <div class="header" style="display: flex; justify-content: space-between; align-items: center;">
            <div>
                <a class="title-main" href="index.php">
                    <img src="photos/logo.png" style="height: 60px; width: auto;"/>
                    <h1 class="title-main"> MARATHON || </h1>
                    <h6 class="title-sub"> Powered by KAT </h6>
                </a>
            </div>
        </div>
        <div class="nav-buttons">
            <?php if (!isset($_SESSION['user_id'])): ?>
            
                <a class="button" href="login.php">LOGIN for more</a>
            
            <?php else: ?>
            
                <?php
                    $avatar = $user['avatar'] ?? 'default.png';
                ?>

                <a href="profile.php">
                    <img class="image" src="avatars/<?php echo htmlspecialchars($avatar); ?>"/>
                </a>
            
                <?php if (isset($_SESSION['role']) && $_SESSION['role'] === 'admin'): ?>
                    <a href="admin.php"><img class="image" src="photos/addStar.jpg"/></a>
                <?php endif; ?>
                
                <a href="logout.php"><img class="image" src="photos/exit.jpg"/></a>
                
            <?php endif; ?>
        </div>

        <div style="display: flex; gap: 40px; padding: 40px 80px;">
            <img src="<?php echo htmlspecialchars($media['poster_url']); ?>" style="width: 250px; height: 370px; object-fit: cover; border-radius: 8px;"/>
            <div style="flex: 1;">
                <h1>
                    <?php echo htmlspecialchars($media['title']); ?>
                    <?php if ($media['type'] != 'movie' && $media['total_seasons'] > 0): ?>
                        <span class="seasons-badge">
                            <?php echo htmlspecialchars($media['total_seasons']); ?> 
                            <?php echo ($media['total_seasons'] == 1) ? 'Season' : 'Seasons'; ?>
                        </span>
                    <?php endif; ?>
                </h1>
                
                <div>
                    <?php echo htmlspecialchars($media['type']); ?> · 
                    <?php echo htmlspecialchars($media['year_pub']); ?>
                    <?php if ($media['type'] == 'movie'): ?>
                        · Movie
                    <?php elseif ($media['type'] == 'show' && $media['total_seasons'] > 0): ?>
                        · TV Series
                    <?php elseif ($media['type'] == 'anime' && $media['total_seasons'] > 0): ?>
                        · Anime Series
                    <?php endif; ?>
                </div>

                <?php if (isset($_SESSION['user_id'])): ?>

                    <form method="post" action="update_status.php">
                        <input type="hidden" name="id_media" value="<?php echo (int)$id; ?>"/>
                        <select class="status-select" name="status" onchange="this.form.submit()">
                            <option value="">— Change status —</option>
                            <option value="plan_to_watch" <?php if ($userStatus == 'plan_to_watch') echo 'selected'; ?>>To see</option>
                            <option value="watching"      <?php if ($userStatus == 'watching')      echo 'selected'; ?>>Seeing</option>
                            <option value="completed"     <?php if ($userStatus == 'completed')     echo 'selected'; ?>>Seen</option>
                            <option value="dropped"       <?php if ($userStatus == 'dropped')       echo 'selected'; ?>>Uncompleted</option>
                        </select>
                    </form>

                <?php endif; ?>

                <div class="info-row">
                    <div class="info-label">📖 Plot:</div>
                    <div><?php echo htmlspecialchars($media['description']); ?></div>
                </div>
                
                <div class="info-row">
                    <div class="info-label">🎭 Cast:</div>
                    <div><?php echo htmlspecialchars($media['cast']); ?></div>
                </div>
                
                <div class="info-row">
                    <div class="info-label">🎬 Genre:</div>
                    <div><?php echo htmlspecialchars($media['genres']); ?></div>
                </div>

            </div>
        </div>

        <!-- SEZIONE REVIEWS CON FORM CENTRATO -->
        <div class="review-section">
            <div class="section-divider"></div>
            
            <!-- Form recensione centrato -->
            <?php if (isset($_SESSION['user_id'])): ?>
                <?php if ($userAlreadyReviewed): ?>
                    <div class="already-reviewed">📝 You have already written a review for this title.</div>
                <?php else: ?>
                    <div class="review-form">
                        <h3>✍️ Write a review</h3>
                        <form method="post" action="add_review.php">
                            <input type="hidden" name="id_media" value="<?php echo (int)$id; ?>"/>
                            <div>
                                <label style="font-size: 13px; color: #a0a0c0;">Rating (1-10)</label><br>
                                <input type="number" name="rating" min="1" max="10" required/>
                            </div>
                            <div style="margin-top: 12px;">
                                <label style="font-size: 13px; color: #a0a0c0;">Comment</label><br>
                                <textarea name="comment" placeholder="Write your review..."></textarea>
                            </div>
                            <button type="submit">Publish</button>
                        </form>
                    </div>
                <?php endif; ?>
            <?php endif; ?>

            <div class="section-divider"></div>

            <!-- Lista recensioni -->
            <div class="reviews-container">
                <h2>📝 Reviews</h2>
                <?php if (empty($reviews)): ?>
                    <div style="color: #a0a0c0; font-style: italic;">No reviews yet. Be the first to write one!</div>
                <?php endif; ?>
                <?php foreach ($reviews as $review): ?>
                    <div style="margin: 20px 0; border-bottom: 1px solid #333; padding-bottom: 10px;">
                        <span style="font-weight: bold;"><?php echo htmlspecialchars($review['name']); ?></span>
                        · ⭐ <?php echo htmlspecialchars($review['rating']); ?>/10
                        <div style="margin-top: 10px; color: #d0d0e0;"><?php echo htmlspecialchars($review['comment']); ?></div>
                    </div>
                <?php endforeach; ?>
            </div>
        </div>
    </body>
</html>