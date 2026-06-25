<?php
    require_once 'DbConnector.php';
    session_start();

    $connection = new DbConnector('localhost', 'root', 'root', 'marathon');

    if (isset($_SESSION['user_id'])) {
        $stmtUser = $connection->prepare("SELECT * FROM users WHERE id = :id");
        $stmtUser->execute([':id' => $_SESSION['user_id']]);
        $user = $stmtUser->fetch(PDO::FETCH_ASSOC);
        if ($user) {
            $_SESSION['role'] = $user['role'];
        }
    }

    // BEST MOVIES - solo con recensioni e NON cancellati
    $stmtMovies = $connection->prepare("
        SELECT m.*, AVG(r.rating) as avg_rating, COUNT(r.id) as total_reviews
        FROM media m
        LEFT JOIN reviews r ON m.id = r.id_media
        WHERE m.type = 'movie' AND m.deleted_at IS NULL
        GROUP BY m.id
        ORDER BY avg_rating DESC, total_reviews DESC
        
    ");
    $stmtMovies->execute();
    $topMovies = $stmtMovies->fetchAll(PDO::FETCH_ASSOC);

    // BEST ANIME - solo con recensioni e NON cancellati
    $stmtAnime = $connection->prepare("
        SELECT m.*, AVG(r.rating) as avg_rating, COUNT(r.id) as total_reviews
        FROM media m
        LEFT JOIN reviews r ON m.id = r.id_media
        WHERE m.type = 'anime' AND m.deleted_at IS NULL
        GROUP BY m.id
        ORDER BY avg_rating DESC, total_reviews DESC
        
    ");
    $stmtAnime->execute();
    $topAnime = $stmtAnime->fetchAll(PDO::FETCH_ASSOC);

    // BEST SHOWS - solo con recensioni e NON cancellati
    $stmtShows = $connection->prepare("
        SELECT m.*, AVG(r.rating) as avg_rating, COUNT(r.id) as total_reviews
        FROM media m
        LEFT JOIN reviews r ON m.id = r.id_media
        WHERE m.type = 'show' AND m.deleted_at IS NULL
        GROUP BY m.id
        ORDER BY avg_rating DESC, total_reviews DESC
        
    ");
    $stmtShows->execute();
    $topShows = $stmtShows->fetchAll(PDO::FETCH_ASSOC);

    // Catalogo - solo media NON cancellati
    $statement = $connection->prepare("SELECT * FROM media WHERE deleted_at IS NULL ORDER BY id");
    $statement->execute();
    $results = $statement->fetchAll(PDO::FETCH_ASSOC);
?>

<html>
    <head>
        <meta content="width=device-width, initial-scale=1"/>
        <link rel="stylesheet" href="style.css">
        <title>MARATHON</title>
        <style>
            .scroll-row::-webkit-scrollbar { display: none; }
            .scroll-row { -ms-overflow-style: none; scrollbar-width: none; }
        </style>
    </head>
    <body>
        <div class="header" style="display: flex; align-items: center;">
            <div style="flex: 1;">
                <img src="photos/logo.png" style="height: 60px; width: auto;"/>
                <h1 class="title-main"> MARATHON || </h1>
                <h6 class="title-sub"> Powered by KAT </h6>
            </div>

            <div class="nav-buttons" style="flex: 1; display: flex; justify-content: flex-end;">
                <?php if (!isset($_SESSION['user_id'])): ?>
                    <a class="button" href="login.php">LOGIN for more</a>
                
                <?php elseif (isset($_SESSION['role']) && $_SESSION['role'] === 'admin'): ?>
                    <a href="profile.php">
                        <img class="image" src="avatars/<?php echo htmlspecialchars($user['avatar'] ?? 'default.png'); ?>"/>
                    </a>
                    <a href="admin.php"><img class="image" src="photos/addStar.jpg"/></a>
                    <a href="logout.php"><img class="image" src="photos/exit.jpg"/></a>
                
                <?php else: ?>
                    <a href="profile.php">
                        <img class="image" src="avatars/<?php echo htmlspecialchars($user['avatar'] ?? 'default.png'); ?>"/>
                    </a>
                    <a href="logout.php"><img class="image" src="photos/exit.jpg"/></a>
                <?php endif; ?>
            </div>
        </div>

        <div style="border: 1px solid gray; margin-top: 40px; margin-bottom: 60px;"></div>

        <div class="section-title"> 🔥 BEST MOVIES </div>
        <div class="scroll-row">
            <?php foreach ($topMovies as $m): ?>
                <a href="detail.php?id=<?php echo $m['id']; ?>" style="text-decoration: none; color: inherit;">
                    <div class="media-card">
                        <img class="media-img" src="<?php echo htmlspecialchars($m['poster_url']); ?>" alt=""/>
                        <div class="media-title"><?php echo htmlspecialchars($m['title']); ?></div>
                        <div><?php echo htmlspecialchars($m['type']); ?></div>
                        <div><?php echo htmlspecialchars($m['year_pub']); ?></div>
                    </div>
                </a>
            <?php endforeach; ?>
            <div class="scroll-spacer"></div>
        </div>

        <div class="section-title"> ⛩️ BEST ANIME </div>
        <div class="scroll-row">
            <?php foreach ($topAnime as $a): ?>
                <a href="detail.php?id=<?php echo $a['id']; ?>" style="text-decoration: none; color: inherit;">
                    <div class="media-card">
                        <img class="media-img" src="<?php echo htmlspecialchars($a['poster_url']); ?>" alt=""/>
                        <div class="media-title"><?php echo htmlspecialchars($a['title']); ?></div>
                        <div><?php echo htmlspecialchars($a['type']); ?></div>
                        <div><?php echo htmlspecialchars($a['year_pub']); ?></div>
                    </div>
                </a>
            <?php endforeach; ?>
            <div class="scroll-spacer"></div>
        </div>

        <div class="section-title"> 🧊 BEST SHOWS </div>
        <div class="scroll-row">
            <?php foreach ($topShows as $s): ?>
                <a href="detail.php?id=<?php echo $s['id']; ?>" style="text-decoration: none; color: inherit;">
                    <div class="media-card">
                        <img class="media-img" src="<?php echo htmlspecialchars($s['poster_url']); ?>" alt=""/>
                        <div class="media-title"><?php echo htmlspecialchars($s['title']); ?></div>
                        <div><?php echo htmlspecialchars($s['type']); ?></div>
                        <div><?php echo htmlspecialchars($s['year_pub']); ?></div>
                    </div>
                </a>
            <?php endforeach; ?>
            <div class="scroll-spacer"></div>
        </div>

        <div style="border: 1px solid gray; margin-top: 90px;"></div>

        <!-- Catalogo -->
        <div class="header" style="display: flex; align-items: center; margin-top: 90px;">
            <div style="flex: 1;">
                <img src="photos/logo.png" style="height: 60px; width: auto;"/>
                <h1 class="title-main"> MARATHON || </h1>
                <h6 class="title-sub"> Powered by KAT </h6>
            </div>
            <div style="flex: 1; display: flex; justify-content: center;">
                <input type="text" id="searchInput" placeholder=" Search..." oninput="filterCatalog()" style="
                    background: #22224e;
                    border: 1px solid transparent;
                    padding: 8px 20px;
                    color: #ffffff;
                    width: 100%;
                    max-width: 500px;
                    outline: none;
                "/>
            </div>
        </div>

        <div class="catalog">
            <div class="catalog-title"> ⚜️ ALL MEDIA ⚜️ </div>
            <?php foreach ($results as $media): ?>
                <a href="detail.php?id=<?php echo $media['id']; ?>" style="text-decoration: none; color: inherit;">
                    <div class="catalog-item" data-title="<?php echo strtolower(htmlspecialchars($media['title'])); ?>" data-type="<?php echo strtolower(htmlspecialchars($media['type'])); ?>">
                        <img class="media-img" src="<?php echo htmlspecialchars($media['poster_url']); ?>" alt=""/>
                        <div class="media-title"><?php echo htmlspecialchars($media['title']); ?></div>
                        <div><?php echo htmlspecialchars($media['type']); ?></div>
                        <div><?php echo htmlspecialchars($media['year_pub']); ?></div>
                    </div>
                </a>
            <?php endforeach; ?>
        </div>

        <script>
            function filterCatalog() {
                var query = document.getElementById('searchInput').value.toLowerCase();
                var items = document.querySelectorAll('.catalog-item');
                    
                items.forEach(function(item) {
                    var title = item.getAttribute('data-title');
                    var type = item.getAttribute('data-type');
                    
                    // Controlla se la query corrisponde al titolo OPPURE al tipo
                    if (title.indexOf(query) !== -1 || type.indexOf(query) !== -1) {
                        item.parentElement.style.display = '';
                    } else {
                        item.parentElement.style.display = 'none';
                    }
                });
            }
        </script>
    </body>
</html>