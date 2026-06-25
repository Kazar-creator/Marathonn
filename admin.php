<?php
require_once 'DbConnector.php';
session_start();

if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'admin') {
    header('Location: index.php');
    exit;
}

$connection = new DbConnector('localhost', 'root', 'root', 'marathon');

$user = null;

if (isset($_SESSION['user_id'])) {
    $stmtUser = $connection->prepare("SELECT * FROM users WHERE id = :id");
    $stmtUser->execute([':id' => $_SESSION['user_id']]);
    $user = $stmtUser->fetch(PDO::FETCH_ASSOC);
}
// Se sto modificando un media, lo carico per precompilare il form
$editMedia = null;
if (isset($_GET['edit'])) {
    $stmtEdit = $connection->prepare("SELECT * FROM media WHERE id = :id AND deleted_at IS NULL");
    $stmtEdit->execute([':id' => (int)$_GET['edit']]);
    $editMedia = $stmtEdit->fetch(PDO::FETCH_ASSOC);
}

// Mostra TUTTI i media (anche cancellati), prima quelli attivi poi quelli cancellati
$stmt = $connection->prepare("
    SELECT id, title, type, year_pub, deleted_at 
    FROM media 
    ORDER BY deleted_at IS NOT NULL, id DESC
");
$stmt->execute();
$allMedia = $stmt->fetchAll(PDO::FETCH_ASSOC);

$avatar = $_SESSION['avatar'] ?? 'default.png';

?>
<html>
<head>
    <meta content="width=device-width, initial-scale=1"/>
    <link rel="stylesheet" href="style.css">
    <title>MARATHON - Admin</title>
    <style>
        .admin-wrap {
            display: flex;
            gap: 40px;
            padding: 40px 80px 60px;
        }

        /* Form */
        .admin-form {
            width: 380px;
            flex-shrink: 0;
            background: rgba(255,255,255,0.03);
            border: 1px solid #2a2a4a;
            border-radius: 10px;
            padding: 24px;
            position: sticky;
            top: 20px;
            align-self: flex-start;
        }
        .admin-form h2 {
            margin: 0 0 20px;
            color: #8ab4f8;
            font-size: 18px;
        }
        .admin-form label {
            font-size: 12px;
            color: #a0a0c0;
            display: block;
            margin-top: 12px;
            margin-bottom: 4px;
        }
        .admin-form input,
        .admin-form select,
        .admin-form textarea {
            width: 100%;
            background: #1a1a2e;
            border: 1px solid #3a3a5a;
            border-radius: 6px;
            color: #eaeaf0;
            font-size: 14px;
            padding: 8px 10px;
            box-sizing: border-box;
            outline: none;
        }
        .admin-form textarea {
            resize: vertical;
            min-height: 80px;
        }
        .btn-submit {
            margin-top: 16px;
            width: 100%;
            background: #8ab4f8;
            color: #0f0f1a;
            border: none;
            border-radius: 6px;
            padding: 10px;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
        }
        .btn-submit:hover { background: #aac8ff; }
        .btn-cancel {
            margin-top: 8px;
            width: 100%;
            background: transparent;
            color: #a0a0c0;
            border: 1px solid #3a3a5a;
            border-radius: 6px;
            padding: 8px;
            font-size: 13px;
            cursor: pointer;
            text-decoration: none;
            display: block;
            text-align: center;
        }
        .btn-cancel:hover { color: #ffffff; }

        /* Tabella media */
        .admin-table-wrap { flex: 1; }
        .admin-table-wrap h2 {
            color: #8ab4f8;
            font-size: 18px;
            margin: 0 0 16px;
        }
        .admin-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
        }
        .admin-table th {
            text-align: left;
            color: #a0a0c0;
            padding: 8px 12px;
            border-bottom: 1px solid #2a2a4a;
            font-weight: normal;
        }
        .admin-table td {
            padding: 10px 12px;
            border-bottom: 1px solid #1a1a2e;
            vertical-align: middle;
        }
        .admin-table tr:hover td { background: rgba(255,255,255,0.02); }
        .btn-edit {
            background: #1a4a8a;
            color: #ffffff;
            border: none;
            border-radius: 5px;
            padding: 5px 12px;
            font-size: 12px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }
        .btn-edit:hover { background: #2a5a9a; }
        .btn-delete {
            background: #7a1a1a;
            color: #ffffff;
            border: none;
            border-radius: 5px;
            padding: 5px 12px;
            font-size: 12px;
            cursor: pointer;
            margin-left: 6px;
        }
        .btn-delete:hover { background: #9a2a2a; }
        .btn-restore {
            background: #4caf50;
            color: #ffffff;
            border: none;
            border-radius: 5px;
            padding: 5px 12px;
            font-size: 12px;
            cursor: pointer;
        }
        .btn-restore:hover { background: #5bc75b; }
        .btn-hard {
            background: #f44336;
            color: #ffffff;
            border: none;
            border-radius: 5px;
            padding: 5px 12px;
            font-size: 12px;
            cursor: pointer;
            margin-left: 6px;
        }
        .btn-hard:hover { background: #ff5548; }
        .type-badge {
            font-size: 11px;
            padding: 2px 8px;
            border-radius: 20px;
            background: #2a2a4a;
            color: #a0a0c0;
        }
        .status-active {
            color: #88ff88;
        }
        .status-deleted {
            color: #ff8888;
        }
        .deleted-row {
            background: #442222;
        }
    </style>
    <title>MARATHON</title>
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
        <?php if (!isset($_SESSION['user_id'])): ?>
        
            <a class="button" href="login.php">LOGIN for more</a>
        
        <?php else: ?>
        
            <?php
                // sicurezza: usa avatar da sessione (già salvato in login)
                $avatar = $_SESSION['avatar'] ?? 'default.png';
        
                if ($avatar === '' || $avatar === null) {
                    $avatar = 'default.png';
                }
            ?>
    
            <a href="profile.php">
                <img class="image" src="avatars/<?php echo htmlspecialchars($avatar); ?>"/>
            </a>
        
            <?php if (($_SESSION['role'] ?? '') === 'admin'): ?>
                <a href="admin.php">
                    <img class="image" src="photos/addStar.jpg"/>
                </a>
            <?php endif; ?>
            
            <a href="logout.php">
                <img class="image" src="photos/exit.jpg"/>
            </a>
            
        <?php endif; ?>
    </div>

    <div class="admin-wrap">

        <!-- Form aggiungi / modifica -->
        <div class="admin-form">
            <?php if ($editMedia): ?>
                <h2>Edit media</h2>
                <form method="post" action="admin_action.php">
                    <input type="hidden" name="action" value="edit"/>
                    <input type="hidden" name="id" value="<?php echo $editMedia['id']; ?>"/>
            <?php else: ?>
                <h2>Add media</h2>
                <form method="post" action="admin_action.php">
                    <input type="hidden" name="action" value="add"/>
            <?php endif; ?>

                <label>Title</label>
                <input type="text" name="title" required value="<?php echo $editMedia ? htmlspecialchars($editMedia['title']) : ''; ?>"/>

                <label>Type</label>
                <select name="type" required>
                    <option value="movie"  <?php if ($editMedia && $editMedia['type'] == 'movie')  echo 'selected'; ?>>Movie</option>
                    <option value="show"   <?php if ($editMedia && $editMedia['type'] == 'show')   echo 'selected'; ?>>Show</option>
                    <option value="anime"  <?php if ($editMedia && $editMedia['type'] == 'anime')  echo 'selected'; ?>>Anime</option>
                </select>

                <label>Year</label>
                <input type="number" name="year_pub" min="1900" max="2100" value="<?php echo $editMedia ? htmlspecialchars($editMedia['year_pub']) : ''; ?>"/>

                <label>Total seasons</label>
                <input type="number" name="total_seasons" min="1" value="<?php echo $editMedia ? htmlspecialchars($editMedia['total_seasons']) : '1'; ?>"/>

                <label>Poster URL</label>
                <input type="text" name="poster_url" value="<?php echo $editMedia ? htmlspecialchars($editMedia['poster_url']) : ''; ?>"/>

                <label>Genres</label>
                <input type="text" name="genres" placeholder="e.g. Drama, Crime" value="<?php echo $editMedia ? htmlspecialchars($editMedia['genres']) : ''; ?>"/>

                <label>Cast</label>
                <input type="text" name="cast" value="<?php echo $editMedia ? htmlspecialchars($editMedia['cast']) : ''; ?>"/>

                <label>Description</label>
                <textarea name="description"><?php echo $editMedia ? htmlspecialchars($editMedia['description']) : ''; ?></textarea>

                <button class="btn-submit" type="submit">
                    <?php echo $editMedia ? 'Save changes' : 'Add media'; ?>
                </button>

            </form>

            <?php if ($editMedia): ?>
                <a class="btn-cancel" href="admin.php">Cancel</a>
            <?php endif; ?>
        </div>

        <!-- Tabella tutti i media -->
        <div class="admin-table-wrap">
            <h2>All media (<?php echo count($allMedia); ?>)</h2>
            <input 
                type="text" 
                id="adminSearch" 
                onkeyup="filterAdminTable()" 
                placeholder="Search title..." 
                style="
                    width: 100%;
                    padding: 10px;
                    margin-bottom: 15px;
                    border-radius: 6px;
                    border: 1px solid #3a3a5a;
                    background: #1a1a2e;
                    color: #eaeaf0;
                    outline: none;
                "
            >
            <table class="admin-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Title</th>
                        <th>Type</th>
                        <th>Year</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($allMedia as $m): ?>
                        <tr class="<?php echo $m['deleted_at'] ? 'deleted-row' : ''; ?>">
                            <td style="color: #606080;"><?php echo $m['id']; ?></td>
                            <td><?php echo htmlspecialchars($m['title']); ?></td>
                            <td><span class="type-badge"><?php echo $m['type']; ?></span></td>
                            <td style="color: #a0a0c0;"><?php echo $m['year_pub']; ?></td>
                            <td>
                                <?php if ($m['deleted_at']): ?>
                                    <span class="status-deleted">DELETED</span><br>
                                    <small><?php echo $m['deleted_at']; ?></small>
                                <?php else: ?>
                                    <span class="status-active">ACTIVE</span>
                                <?php endif; ?>
                            </td>
                            <td>
                                <?php if ($m['deleted_at']): ?>
                                    <!-- RESTORE button -->
                                    <form method="post" action="admin_action.php" style="display: inline;">
                                        <input type="hidden" name="action" value="restore"/>
                                        <input type="hidden" name="id" value="<?php echo $m['id']; ?>"/>
                                        <button class="btn-restore" type="submit" onclick="return confirm('Restore <?php echo htmlspecialchars($m['title']); ?>?')">Restore</button>
                                    </form>
                                    <!-- HARD DELETE button -->
                                    <form method="post" action="admin_action.php" style="display: inline;">
                                        <input type="hidden" name="action" value="hard_delete"/>
                                        <input type="hidden" name="id" value="<?php echo $m['id']; ?>"/>
                                        <button class="btn-hard" type="submit" onclick="return confirm('⚠️ PERMANENTLY delete <?php echo htmlspecialchars($m['title']); ?>? This cannot be undone!')">Hard Delete</button>
                                    </form>
                                <?php else: ?>
                                    <!-- EDIT button -->
                                    <a class="btn-edit" href="admin.php?edit=<?php echo $m['id']; ?>">Edit</a>
                                    <!-- SOFT DELETE button -->
                                    <form method="post" action="admin_action.php" style="display: inline;">
                                        <input type="hidden" name="action" value="delete"/>
                                        <input type="hidden" name="id" value="<?php echo $m['id']; ?>"/>
                                        <button class="btn-delete" type="submit" onclick="return confirm('Move <?php echo htmlspecialchars($m['title']); ?> to trash? You can restore it later.')">Delete</button>
                                    </form>
                                <?php endif; ?>
                            </td>
                        </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
        </div>

    </div>
    <script>
        function filterAdminTable() {
            let input = document.getElementById("adminSearch");
            let filter = input.value.toLowerCase();
            let rows = document.querySelectorAll(".admin-table tbody tr");
            
            rows.forEach(row => {
                let title = row.querySelectorAll("td")[1].textContent.toLowerCase();
                
                if (title.includes(filter)) {
                    row.style.display = "";
                } else {
                    row.style.display = "none";
                }
            });
        }
    </script>
</body>
</html>