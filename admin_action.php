<?php
require_once 'DbConnector.php';
session_start();

if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'admin' || $_SERVER['REQUEST_METHOD'] !== 'POST') {
    header('Location: index.php');
    exit;
}

$connection = new DbConnector('localhost', 'root', 'root', 'marathon');
$action = $_POST['action'];

if ($action == 'add') {

    $stmt = $connection->prepare("
        INSERT INTO media (title, type, year_pub, total_seasons, poster_url, genres, cast, description, deleted_at)
        VALUES (:title, :type, :year_pub, :total_seasons, :poster_url, :genres, :cast, :description, NULL)
    ");
    $stmt->execute([
        ':title'         => $_POST['title'],
        ':type'          => $_POST['type'],
        ':year_pub'      => $_POST['year_pub'],
        ':total_seasons' => $_POST['total_seasons'],
        ':poster_url'    => $_POST['poster_url'],
        ':genres'        => $_POST['genres'],
        ':cast'          => $_POST['cast'],
        ':description'   => $_POST['description'],
    ]);
    header('Location: admin.php');
    exit;

} elseif ($action == 'edit') {

    $stmt = $connection->prepare("
        UPDATE media SET
            title         = :title,
            type          = :type,
            year_pub      = :year_pub,
            total_seasons = :total_seasons,
            poster_url    = :poster_url,
            genres        = :genres,
            cast          = :cast,
            description   = :description
        WHERE id = :id AND deleted_at IS NULL
    ");
    $stmt->execute([
        ':title'         => $_POST['title'],
        ':type'          => $_POST['type'],
        ':year_pub'      => $_POST['year_pub'],
        ':total_seasons' => $_POST['total_seasons'],
        ':poster_url'    => $_POST['poster_url'],
        ':genres'        => $_POST['genres'],
        ':cast'          => $_POST['cast'],
        ':description'   => $_POST['description'],
        ':id'            => (int)$_POST['id'],
    ]);
    header('Location: admin.php');
    exit;

} elseif ($action == 'delete') {

    // SOFT DELETE: invece di eliminare, aggiorna deleted_at
    $stmt = $connection->prepare("
        UPDATE media SET deleted_at = NOW() 
        WHERE id = :id AND deleted_at IS NULL
    ");
    $stmt->execute([':id' => (int)$_POST['id']]);
    header('Location: admin.php');
    exit;

} elseif ($action == 'restore') {

    // RIPRISTINA un media cancellato
    $stmt = $connection->prepare("
        UPDATE media SET deleted_at = NULL 
        WHERE id = :id
    ");
    $stmt->execute([':id' => (int)$_POST['id']]);
    header('Location: admin.php');
    exit;

} elseif ($action == 'hard_delete') {

    // HARD DELETE: elimina fisicamente (solo per admin)
    $stmt = $connection->prepare("DELETE FROM media WHERE id = :id");
    $stmt->execute([':id' => (int)$_POST['id']]);
    header('Location: admin.php');
    exit;
}

header('Location: admin.php');
exit;