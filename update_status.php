<?php
require_once 'DbConnector.php';
session_start();

if (!isset($_SESSION['user_id']) || $_SERVER['REQUEST_METHOD'] !== 'POST') {
    header('Location: index.php');
    exit;
}

$idMedia = (int)$_POST['id_media'];
$status  = $_POST['status'];
$allowed = ['plan_to_watch', 'watching', 'completed', 'dropped'];

if (!$idMedia || !in_array($status, $allowed)) {
    header("Location: detail.php?id=$idMedia");
    exit;
}

$connection = new DbConnector('localhost', 'root', 'root', 'marathon');

// INSERT se non esiste, UPDATE se esiste già (ON DUPLICATE KEY)
$stmt = $connection->prepare("
    INSERT INTO user_library (id_user, id_media, status)
    VALUES (:uid, :mid, :status)
    ON DUPLICATE KEY UPDATE status = :status
");
$stmt->execute([
    ':uid'    => $_SESSION['user_id'],
    ':mid'    => $idMedia,
    ':status' => $status,
]);

header("Location: detail.php?id=$idMedia");
exit;
