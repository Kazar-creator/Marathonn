<?php
require_once 'DbConnector.php';
session_start();

if (!isset($_SESSION['user_id']) || $_SERVER['REQUEST_METHOD'] !== 'POST') {
    header('Location: index.php');
    exit;
}

$idMedia = (int)$_POST['id_media'];
$rating  = (int)$_POST['rating'];
$comment = $_POST['comment'];

// Controlli base
if (!$idMedia || $rating < 1 || $rating > 10) {
    header("Location: detail.php?id=$idMedia");
    exit;
}

$connection = new DbConnector('localhost', 'root', 'root', 'marathon');

// Controlla che l'utente non abbia già recensito questo media
$stmtCheck = $connection->prepare("SELECT id FROM reviews WHERE id_user = :uid AND id_media = :mid");
$stmtCheck->execute([':uid' => $_SESSION['user_id'], ':mid' => $idMedia]);
if ($stmtCheck->fetch()) {
    header("Location: detail.php?id=$idMedia");
    exit;
}

$stmt = $connection->prepare("
    INSERT INTO reviews (id_user, id_media, rating, comment)
    VALUES (:uid, :mid, :rating, :comment)
");
$stmt->execute([
    ':uid'     => $_SESSION['user_id'],
    ':mid'     => $idMedia,
    ':rating'  => $rating,
    ':comment' => $comment,
]);

header("Location: detail.php?id=$idMedia");
exit;
