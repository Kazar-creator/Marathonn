<?php
    require_once 'DbConnector.php';
    session_start();

    if (!isset($_SESSION['user_id'])) {
        header('Location: login.php');
        exit;
    }

    $connection = new DbConnector('localhost', 'root', 'root', 'marathon');

    $stmtUser = $connection->prepare("SELECT * FROM users WHERE id = :id");
    $stmtUser->execute([':id' => $_SESSION['user_id']]);
    $user = $stmtUser->fetch(PDO::FETCH_ASSOC);

    // Libreria utente - solo media NON cancellati
    $stmtLib = $connection->prepare("
        SELECT ul.status, m.id, m.title, m.poster_url, m.type, m.year_pub
        FROM user_library ul
        JOIN media m ON ul.id_media = m.id
        WHERE ul.id_user = :id AND m.deleted_at IS NULL
        ORDER BY ul.updated_at DESC
    ");
    $stmtLib->execute([':id' => $_SESSION['user_id']]);
    $allMedia = $stmtLib->fetchAll(PDO::FETCH_ASSOC);

    $countCompleted   = 0;
    $countWatching    = 0;
    $countPlanToWatch = 0;
    $countDropped     = 0;

    foreach ($allMedia as $item) {
        if ($item['status'] == 'completed')     $countCompleted++;
        if ($item['status'] == 'watching')      $countWatching++;
        if ($item['status'] == 'plan_to_watch') $countPlanToWatch++;
        if ($item['status'] == 'dropped')       $countDropped++;
    }

    // Reviews dell'utente - solo media NON cancellati
    $stmtReviews = $connection->prepare("
        SELECT r.rating, r.comment, r.created_at, m.id AS media_id, m.title, m.poster_url, m.type
        FROM reviews r
        JOIN media m ON r.id_media = m.id
        WHERE r.id_user = :id AND m.deleted_at IS NULL
        ORDER BY r.id DESC
    ");
    $stmtReviews->execute([':id' => $_SESSION['user_id']]);
    $userReviews = $stmtReviews->fetchAll(PDO::FETCH_ASSOC);

    // Classifica: media completati ordinati per rating - solo media NON cancellati
    $stmtRanking = $connection->prepare("
        SELECT r.rating, m.id, m.title, m.poster_url, m.type, m.year_pub
        FROM reviews r
        JOIN user_library ul ON r.id_media = ul.id_media AND r.id_user = ul.id_user
        JOIN media m ON r.id_media = m.id
        WHERE r.id_user = :id AND ul.status = 'completed' AND m.deleted_at IS NULL
        ORDER BY r.rating DESC
    ");
        $stmtRanking->execute([':id' => $_SESSION['user_id']]);
        $ranking = $stmtRanking->fetchAll(PDO::FETCH_ASSOC);

    // Statistiche utente tramite stored procedure
   // Statistiche utente tramite stored procedure
$stmtStats = $connection->prepare("CALL GetUserStatistics(:id)");
$stmtStats->execute([':id' => $_SESSION['user_id']]);
$stats = $stmtStats->fetch(PDO::FETCH_ASSOC);

        $activeTab = 'completed';
        if (isset($_GET['tab'])) {
            $activeTab = $_GET['tab'];
        }

        //stored procedure(count recensioni)
    

?>
<html>
<head>
    <meta content="width=device-width, initial-scale=1"/>
    <link rel="stylesheet" href="style.css">
    <title>MARATHON - Profile</title>
    <style>
        .profile-hero {
            display: flex;
            align-items: center;
            gap: 24px;
            padding: 40px 80px 0;
        }
        .profile-avatar {
            width: 90px;
            height: 90px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #8ab4f8;
        }
        .profile-name {
            font-size: 26px;
            font-weight: bold;
            color: #ffffff;
        }
        .profile-email {
            color: #a0a0c0;
            font-size: 13px;
            margin-top: 4px;
        }
        .tab-bar {
            display: flex;
            gap: 4px;
            padding: 30px 80px 0;
            border-bottom: 1px solid #2a2a4a;
        }
        .tab {
            text-decoration: none;
            color: #a0a0c0;
            padding: 8px 20px;
            font-size: 15px;
            border-bottom: 3px solid transparent;
        }
        .tab:hover { color: #ffffff; }
        .tab.active {
            color: #ffffff;
            font-weight: bold;
            border-bottom: 3px solid #8ab4f8;
        }
        .tab-count {
            font-size: 12px;
            color: #606080;
            margin-left: 5px;
        }
        .tab.active .tab-count { color: #8ab4f8; }

        /* Griglia poster */
        .grid {
            display: flex;
            flex-wrap: wrap;
            gap: 12px;
            padding: 30px 80px 60px;
        }
        .grid-card {
            width: 120px;
            cursor: pointer;
            transition: transform 0.2s;
        }
        .grid-card:hover { transform: scale(1.05); }
        .grid-card img {
            width: 120px;
            height: 178px;
            object-fit: cover;
            border-radius: 6px;
            display: block;
        }
        .grid-card-title {
            font-size: 12px;
            color: #c0c0d8;
            margin-top: 5px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .grid-empty {
            padding: 40px 0;
            color: #a0a0c0;
            font-style: italic;
        }

        /* Reviews */
        .reviews-list {
            padding: 30px 80px 60px;
            display: flex;
            flex-direction: column;
            gap: 16px;
        }
        .review-card {
            display: flex;
            gap: 20px;
            background: rgba(255,255,255,0.03);
            border: 1px solid #2a2a4a;
            border-radius: 10px;
            padding: 16px;
            align-items: flex-start;
        }
        .review-poster {
            width: 55px;
            height: 80px;
            object-fit: cover;
            border-radius: 5px;
            flex-shrink: 0;
        }
        .review-media-title {
            font-size: 15px;
            font-weight: bold;
            color: #8ab4f8;
            text-decoration: none;
        }
        .review-media-title:hover { text-decoration: underline; }
        .review-rating {
            font-size: 14px;
            color: #ffcc44;
            margin: 4px 0 8px;
        }
        .review-comment {
            font-size: 13px;
            color: #c0c0d8;
            line-height: 1.5;
        }
        .review-date {
            font-size: 11px;
            color: #606080;
            margin-top: 6px;
        }

        /* Ranking */
        .ranking-list {
            padding: 30px 80px 60px;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }
        .ranking-row {
            display: flex;
            align-items: center;
            gap: 20px;
            background: rgba(255,255,255,0.03);
            border: 1px solid #2a2a4a;
            border-radius: 10px;
            padding: 12px 16px;
            text-decoration: none;
            color: inherit;
            transition: background 0.2s;
        }
        .ranking-row:hover { background: rgba(255,255,255,0.07); }
        .ranking-pos {
            font-size: 22px;
            font-weight: bold;
            color: #8ab4f8;
            width: 36px;
            text-align: center;
            flex-shrink: 0;
        }
        .ranking-pos.gold   { color: #ffd700; }
        .ranking-pos.silver { color: #c0c0c0; }
        .ranking-pos.bronze { color: #cd7f32; }
        .ranking-poster {
            width: 44px;
            height: 64px;
            object-fit: cover;
            border-radius: 4px;
            flex-shrink: 0;
        }
        .ranking-info { flex: 1; }
        .ranking-title {
            font-size: 15px;
            font-weight: bold;
            color: #ffffff;
        }
        .ranking-meta {
            font-size: 12px;
            color: #a0a0c0;
            margin-top: 3px;
        }
        .ranking-score {
            font-size: 22px;
            font-weight: bold;
            color: #ffcc44;
            flex-shrink: 0;
        }
        .ranking-score span {
            font-size: 13px;
            color: #606080;
        }

        /* Statistics - Stili migliorati */
        .stats-container {
            padding: 30px 80px 60px;
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .stats-header {
            text-align: center;
            margin-bottom: 40px;
        }
        
        .stats-header h2 {
            color: #ffffff;
            font-size: 28px;
            margin-bottom: 8px;
        }
        
        .stats-header p {
            color: #a0a0c0;
            font-size: 14px;
        }
        
        /* Griglia principale */
        .stats-dashboard {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 24px;
            margin-bottom: 40px;
        }
        
        /* Card statistiche */
        .stat-card-modern {
            background: linear-gradient(135deg, rgba(255,255,255,0.05) 0%, rgba(255,255,255,0.02) 100%);
            border: 1px solid rgba(138,180,248,0.2);
            border-radius: 20px;
            padding: 24px;
            transition: transform 0.3s, border-color 0.3s;
        }
        
        .stat-card-modern:hover {
            transform: translateY(-5px);
            border-color: rgba(138,180,248,0.5);
        }
        
        .stat-card-header {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 20px;
            border-bottom: 1px solid rgba(138,180,248,0.2);
            padding-bottom: 12px;
        }
        
        .stat-icon {
            font-size: 32px;
        }
        
        .stat-card-header h3 {
            color: #8ab4f8;
            font-size: 16px;
            font-weight: 600;
            margin: 0;
        }
        
        /* Anelli di progresso */
        .progress-ring-container {
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 20px 0;
        }
        
        .progress-ring {
            position: relative;
            width: 150px;
            height: 150px;
        }
        
        .progress-ring svg {
            width: 150px;
            height: 150px;
            transform: rotate(-90deg);
        }
        
        .progress-ring-circle-bg {
            fill: none;
            stroke: rgba(255,255,255,0.1);
            stroke-width: 8;
        }
        
        .progress-ring-circle {
            fill: none;
            stroke: #8ab4f8;
            stroke-width: 8;
            stroke-linecap: round;
            stroke-dasharray: 452;
            stroke-dashoffset: 452;
            transition: stroke-dashoffset 1s ease;
        }
        
        .progress-ring-circle.completed { stroke: #4caf50; }
        .progress-ring-circle.watching { stroke: #ff9800; }
        .progress-ring-circle.plan { stroke: #2196f3; }
        .progress-ring-circle.dropped { stroke: #f44336; }
        
        .progress-ring-text {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            text-align: center;
        }
        
        .progress-ring-value {
            font-size: 28px;
            font-weight: bold;
            color: #ffffff;
        }
        
        .progress-ring-label {
            font-size: 11px;
            color: #a0a0c0;
            margin-top: 4px;
        }
        
        /* Barre di avanzamento */
        .progress-bar-container {
            margin: 15px 0;
        }
        
        .progress-bar-label {
            display: flex;
            justify-content: space-between;
            margin-bottom: 8px;
            font-size: 13px;
            color: #c0c0d8;
        }
        
        .progress-bar-bg {
            background: rgba(255,255,255,0.1);
            border-radius: 10px;
            overflow: hidden;
            height: 8px;
        }
        
        .progress-bar-fill {
            height: 100%;
            border-radius: 10px;
            transition: width 1s ease;
            width: 0%;
        }
        
        .progress-bar-fill.completed { background: linear-gradient(90deg, #4caf50, #66bb6a); }
        .progress-bar-fill.watching { background: linear-gradient(90deg, #ff9800, #ffb74d); }
        .progress-bar-fill.plan { background: linear-gradient(90deg, #2196f3, #42a5f5); }
        .progress-bar-fill.dropped { background: linear-gradient(90deg, #f44336, #ef5350); }
        
        /* Rating stars */
        .rating-display {
            display: flex;
            align-items: baseline;
            justify-content: center;
            gap: 8px;
            margin: 20px 0;
        }
        
        .rating-number {
            font-size: 48px;
            font-weight: bold;
            color: #ffd700;
        }
        
        .rating-max {
            font-size: 20px;
            color: #606080;
        }
        
        .stars {
            color: #ffd700;
            font-size: 20px;
            letter-spacing: 4px;
            text-align: center;
        }
        
        /* Mini grafici a barre per categorie */
        .category-bars {
            margin-top: 20px;
        }
        
        .category-item {
            margin-bottom: 12px;
        }
        
        .category-name {
            font-size: 12px;
            color: #a0a0c0;
            margin-bottom: 5px;
            display: flex;
            justify-content: space-between;
        }
        
        .category-bar-bg {
            background: rgba(255,255,255,0.1);
            border-radius: 4px;
            height: 6px;
            overflow: hidden;
        }
        
        .category-bar {
            height: 100%;
            border-radius: 4px;
            transition: width 1s ease;
            width: 0%;
        }
        
        /* Badge achievements */
        .achievements {
            grid-column: 1 / -1;
            background: linear-gradient(135deg, rgba(138,180,248,0.1) 0%, rgba(138,180,248,0.02) 100%);
            border-radius: 20px;
            padding: 24px;
        }
        
        .achievements h3 {
            color: #8ab4f8;
            margin-bottom: 20px;
            font-size: 18px;
        }
        
        .badges-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 16px;
            justify-content: center;
        }
        
        .badge {
            text-align: center;
            padding: 12px 20px;
            background: rgba(255,255,255,0.05);
            border-radius: 50px;
            transition: transform 0.3s;
        }
        
        .badge:hover {
            transform: scale(1.05);
            background: rgba(138,180,248,0.2);
        }
        
        .badge-icon {
            font-size: 28px;
            display: block;
            margin-bottom: 6px;
        }
        
        .badge-name {
            font-size: 12px;
            color: #c0c0d8;
        }
        
        .badge-unlocked {
            opacity: 1;
        }
        
        .badge-locked {
            opacity: 0.4;
            filter: grayscale(0.5);
        }
        
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .stat-card-modern {
            animation: fadeInUp 0.5s ease forwards;
        }
        
        .stat-card-modern:nth-child(1) { animation-delay: 0.1s; }
        .stat-card-modern:nth-child(2) { animation-delay: 0.2s; }
        .stat-card-modern:nth-child(3) { animation-delay: 0.3s; }
        
        @media (max-width: 768px) {
            .stats-container { padding: 20px; }
            .stats-dashboard { grid-template-columns: 1fr; }
            .progress-ring { width: 120px; height: 120px; }
            .progress-ring svg { width: 120px; height: 120px; }
            .tab-bar { padding: 20px 20px 0; overflow-x: auto; }
            .grid { padding: 20px; }
            .reviews-list { padding: 20px; }
            .ranking-list { padding: 20px; }
        }
    </style>
</head>
<body>

    <div class="header" style="display: flex; justify-content: space-between; align-items: center;">
        <div>
            <a class="title-main" href="index.php">
                <img src="photos/logo.png" style="height: 60px; width: auto;"/>
                <h1 class="title-main">MARATHON ||</h1>
                <h6 class="title-sub">Powered by KAT</h6>
            </a>
        </div>
    </div>
    <div class="nav-buttons">
        <?php if (!isset($_SESSION['user_id'])) {
            echo '<a class="button" href="login.php">LOGIN for more</a>';
        } else {
    
            echo '<a href="profile.php"><img class="image" src="avatars/' . htmlspecialchars($user['avatar']) . '"/></a>';
    
            if (isset($_SESSION['role']) && $_SESSION['role'] === 'admin') {
                echo '<a href="admin.php"><img class="image" src="photos/addStar.jpg"/></a>';
            }
    
            echo '<a href="logout.php"><img class="image" src="photos/exit.jpg"/></a>';
        } ?>
    </div>

    <div class="profile-hero">
        <img class="profile-avatar" src="avatars/<?php echo htmlspecialchars($user['avatar'] ?? 'default.png'); ?>"/>
        <div>
            <div class="profile-name"><?php echo htmlspecialchars($user['name'] . ' ' . $user['surname']); ?></div>
            <div class="profile-email"><?php echo htmlspecialchars($user['email']); ?></div>
            
        </div>
    </div>
    </div>

    <div class="tab-bar">
        <?php if ($activeTab == 'completed'): ?>
            <a href="profile.php?tab=completed" class="tab active">Seen <span class="tab-count"><?php echo $countCompleted; ?></span></a>
        <?php else: ?>
            <a href="profile.php?tab=completed" class="tab">Seen <span class="tab-count"><?php echo $countCompleted; ?></span></a>
        <?php endif; ?>

        <?php if ($activeTab == 'watching'): ?>
            <a href="profile.php?tab=watching" class="tab active">Seeing <span class="tab-count"><?php echo $countWatching; ?></span></a>
        <?php else: ?>
            <a href="profile.php?tab=watching" class="tab">Seeing <span class="tab-count"><?php echo $countWatching; ?></span></a>
        <?php endif; ?>

        <?php if ($activeTab == 'plan_to_watch'): ?>
            <a href="profile.php?tab=plan_to_watch" class="tab active">To see <span class="tab-count"><?php echo $countPlanToWatch; ?></span></a>
        <?php else: ?>
            <a href="profile.php?tab=plan_to_watch" class="tab">To see <span class="tab-count"><?php echo $countPlanToWatch; ?></span></a>
        <?php endif; ?>

        <?php if ($activeTab == 'dropped'): ?>
            <a href="profile.php?tab=dropped" class="tab active">Uncompleted <span class="tab-count"><?php echo $countDropped; ?></span></a>
        <?php else: ?>
            <a href="profile.php?tab=dropped" class="tab">Uncompleted <span class="tab-count"><?php echo $countDropped; ?></span></a>
        <?php endif; ?>

        <?php if ($activeTab == 'reviews'): ?>
            <a href="profile.php?tab=reviews" class="tab active">Reviews <span class="tab-count"><?php echo count($userReviews); ?></span></a>
        <?php else: ?>
            <a href="profile.php?tab=reviews" class="tab">Reviews <span class="tab-count"><?php echo count($userReviews); ?></span></a>
        <?php endif; ?>

        <?php if ($activeTab == 'ranking'): ?>
            <a href="profile.php?tab=ranking" class="tab active">Ranking <span class="tab-count"><?php echo count($ranking); ?></span></a>
        <?php else: ?>
            <a href="profile.php?tab=ranking" class="tab">Ranking <span class="tab-count"><?php echo count($ranking); ?></span></a>
        <?php endif; ?>

        <?php if ($activeTab == 'stats'): ?>
            <a href="profile.php?tab=stats" class="tab active">Statistics</a>
        <?php else: ?>
            <a href="profile.php?tab=stats" class="tab">Statistics</a>
        <?php endif; ?>
    </div>

    <!-- TAB: griglia media -->
    <?php if ($activeTab == 'completed' || $activeTab == 'watching' || $activeTab == 'plan_to_watch' || $activeTab == 'dropped'): ?>
        <div class="grid">
            <?php
                $found = false;
                foreach ($allMedia as $item):
                    if ($item['status'] != $activeTab) continue;
                    $found = true;
            ?>
                <a href="detail.php?id=<?php echo $item['id']; ?>" style="text-decoration: none; color: inherit;">
                    <div class="grid-card">
                        <img src="<?php echo htmlspecialchars($item['poster_url']); ?>" alt=""/>
                        <div class="grid-card-title"><?php echo htmlspecialchars($item['title']); ?></div>
                    </div>
                </a>
            <?php endforeach; ?>
            <?php if (!$found): ?>
                <div class="grid-empty">No titles in this category.</div>
            <?php endif; ?>
        </div>

    <!-- TAB: reviews -->
    <?php elseif ($activeTab == 'reviews'): ?>
        <div class="reviews-list">
            <?php if (empty($userReviews)): ?>
                <div class="grid-empty">You have not written any reviews yet.</div>
            <?php else: ?>
                <?php foreach ($userReviews as $review): ?>
                    <div class="review-card">
                        <img class="review-poster" src="<?php echo htmlspecialchars($review['poster_url']); ?>" alt=""/>
                        <div>
                            <a class="review-media-title" href="detail.php?id=<?php echo $review['media_id']; ?>">
                                <?php echo htmlspecialchars($review['title']); ?>
                            </a>
                            <div class="review-rating">
                                <?php echo $review['rating']; ?> / 10
                            </div>
                            <div class="review-comment"><?php echo htmlspecialchars($review['comment']); ?></div>
                            <div class="review-date"><?php echo htmlspecialchars($review['created_at']); ?></div>
                        </div>
                    </div>
                <?php endforeach; ?>
            <?php endif; ?>
        </div>

    <!-- TAB: ranking -->
    <?php elseif ($activeTab == 'ranking'): ?>
        <div class="ranking-list">
            <?php if (empty($ranking)): ?>
                <div class="grid-empty">No scored titles yet.</div>
            <?php else: ?>
                <?php $pos = 1; foreach ($ranking as $r): ?>
                    <a class="ranking-row" href="detail.php?id=<?php echo $r['id']; ?>">
                        <?php if ($pos == 1): ?>
                            <div class="ranking-pos gold">#1</div>
                        <?php elseif ($pos == 2): ?>
                            <div class="ranking-pos silver">#2</div>
                        <?php elseif ($pos == 3): ?>
                            <div class="ranking-pos bronze">#3</div>
                        <?php else: ?>
                            <div class="ranking-pos">#<?php echo $pos; ?></div>
                        <?php endif; ?>
                        <img class="ranking-poster" src="<?php echo htmlspecialchars($r['poster_url']); ?>" alt=""/>
                        <div class="ranking-info">
                            <div class="ranking-title"><?php echo htmlspecialchars($r['title']); ?></div>
                            <div class="ranking-meta"><?php echo htmlspecialchars($r['type']); ?> · <?php echo htmlspecialchars($r['year_pub']); ?></div>
                        </div>
                        <div class="ranking-score"><?php echo $r['rating']; ?> <span>/ 10</span></div>
                    </a>
                <?php $pos++; endforeach; ?>
            <?php endif; ?>
        </div>

    <!-- TAB: statistics MIGLIORATA -->
    <?php elseif ($activeTab == 'stats'): ?>
        <div class="stats-container">
            <div class="stats-header">
                <h2>📊 Your Statistics Dashboard</h2>
                <p>Visualizza i tuoi progressi e le tue statistiche di visione</p>
            </div>
            
            <div class="stats-dashboard">
                <!-- Card 1: Progress Ring - Completamento totale -->
                <div class="stat-card-modern">
                    <div class="stat-card-header">
                        <div class="stat-icon">🎯</div>
                        <h3>Overall Progress</h3>
                    </div>
                    <div class="progress-ring-container">
                        <div class="progress-ring">
                            <svg>
                                <circle class="progress-ring-circle-bg" cx="75" cy="75" r="72"></circle>
                                <circle class="progress-ring-circle completed" cx="75" cy="75" r="72" 
                                        stroke-dasharray="452" stroke-dashoffset="<?php echo 452 - (452 * $stats['completati'] / max($stats['totale_libreria'], 1)); ?>">
                                </circle>
                            </svg>
                            <div class="progress-ring-text">
                                <div class="progress-ring-value"><?php echo round(($stats['completati'] / max($stats['totale_libreria'], 1)) * 100); ?>%</div>
                                <div class="progress-ring-label">Completed</div>
                            </div>
                        </div>
                    </div>
                    <div class="progress-bar-container">
                        <div class="progress-bar-label">
                            <span>📺 Completed</span>
                            <span><?php echo $stats['completati']; ?> / <?php echo $stats['totale_libreria']; ?></span>
                        </div>
                        <div class="progress-bar-bg">
                            <div class="progress-bar-fill completed" style="width: <?php echo ($stats['completati'] / max($stats['totale_libreria'], 1)) * 100; ?>%"></div>
                        </div>
                    </div>
                </div>
                
                <!-- Card 2: Distribuzione stato libreria -->
                <div class="stat-card-modern">
                    <div class="stat-card-header">
                        <div class="stat-icon">📚</div>
                        <h3>Library Distribution</h3>
                    </div>
                    <div class="category-bars">
                        <?php 
                        $maxCount = max($stats['completati'], $stats['in_corso'], $stats['da_vedere'], $stats['abbandonati']);
                        ?>
                        <div class="category-item">
                            <div class="category-name">
                                <span>✅ Completed</span>
                                <span><?php echo $stats['completati']; ?></span>
                            </div>
                            <div class="category-bar-bg">
                                <div class="category-bar" style="width: <?php echo ($stats['completati'] / max($maxCount, 1)) * 100; ?>%; background: #4caf50;"></div>
                            </div>
                        </div>
                        <div class="category-item">
                            <div class="category-name">
                                <span>▶️ Watching</span>
                                <span><?php echo $stats['in_corso']; ?></span>
                            </div>
                            <div class="category-bar-bg">
                                <div class="category-bar" style="width: <?php echo ($stats['in_corso'] / max($maxCount, 1)) * 100; ?>%; background: #ff9800;"></div>
                            </div>
                        </div>
                        <div class="category-item">
                            <div class="category-name">
                                <span>⏰ Plan to Watch</span>
                                <span><?php echo $stats['da_vedere']; ?></span>
                            </div>
                            <div class="category-bar-bg">
                                <div class="category-bar" style="width: <?php echo ($stats['da_vedere'] / max($maxCount, 1)) * 100; ?>%; background: #2196f3;"></div>
                            </div>
                        </div>
                        <div class="category-item">
                            <div class="category-name">
                                <span>💔 Dropped</span>
                                <span><?php echo $stats['abbandonati']; ?></span>
                            </div>
                            <div class="category-bar-bg">
                                <div class="category-bar" style="width: <?php echo ($stats['abbandonati'] / max($maxCount, 1)) * 100; ?>%; background: #f44336;"></div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Card 3: Rating medio -->
                <div class="stat-card-modern">
                    <div class="stat-card-header">
                        <div class="stat-icon">⭐</div>
                        <h3>Average Rating</h3>
                    </div>
                    <div class="rating-display">
                        <div class="rating-number"><?php echo number_format($stats['media_recensioni'], 1); ?></div>
                        <div class="rating-max">/ 10</div>
                    </div>
                    <div class="stars">
                        <?php 
                        $fullStars = floor($stats['media_recensioni'] / 2);
                        $halfStar = ($stats['media_recensioni'] / 2) - $fullStars >= 0.5;
                        for($i = 0; $i < $fullStars; $i++) echo '★';
                        if($halfStar) echo '½';
                        for($i = $fullStars + ($halfStar ? 1 : 0); $i < 5; $i++) echo '☆';
                        ?>
                    </div>
                    <div style="text-align: center; margin-top: 15px;">
                        <div class="progress-bar-label">
                            <span>📝 Reviews written</span>
                            <span><?php echo $stats['totale_recensioni']; ?></span>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Sezione Achievements / Badges -->
            <div class="achievements">
                <h3>🏆 Achievements & Badges</h3>
                <div class="badges-grid">
                    <?php 
                    $badges = [
                        ['icon' => '🎬', 'name' => 'Movie Buff', 'condition' => $stats['completati'] >= 10],
                        ['icon' => '📺', 'name' => 'Series Master', 'condition' => $stats['completati'] >= 20],
                        ['icon' => '⭐', 'name' => 'Critic', 'condition' => $stats['totale_recensioni'] >= 5],
                        ['icon' => '🔥', 'name' => 'Marathon Runner', 'condition' => $stats['completati'] >= 30],
                        ['icon' => '📝', 'name' => 'Reviewer', 'condition' => $stats['totale_recensioni'] >= 10],
                        ['icon' => '💯', 'name' => 'Perfect Score', 'condition' => $stats['media_recensioni'] >= 9],
                    ];
                    foreach($badges as $badge):
                    ?>
                    <div class="badge <?php echo $badge['condition'] ? 'badge-unlocked' : 'badge-locked'; ?>">
                        <span class="badge-icon"><?php echo $badge['icon']; ?></span>
                        <span class="badge-name"><?php echo $badge['name']; ?></span>
                    </div>
                    <?php endforeach; ?>
                </div>
            </div>
            
            <!-- JavaScript per animazioni -->
            <script>
                document.addEventListener('DOMContentLoaded', function() {
                    const rings = document.querySelectorAll('.progress-ring-circle');
                    rings.forEach(ring => {
                        const offset = ring.getAttribute('stroke-dashoffset');
                        if(offset) {
                            setTimeout(() => {
                                ring.style.strokeDashoffset = offset;
                            }, 100);
                        }
                    });
                    
                    const bars = document.querySelectorAll('.progress-bar-fill, .category-bar');
                    bars.forEach(bar => {
                        const width = bar.style.width;
                        if(width) {
                            bar.style.width = '0%';
                            setTimeout(() => {
                                bar.style.width = width;
                            }, 200);
                        }
                    });
                });
            </script>
        </div>

    <?php endif; ?>

</body>
</html>