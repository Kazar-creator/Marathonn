<?php
require_once 'DbConnector.php';
session_start();

$errorMessageName = false;
$errorMessageSurname = false;
$errorMessageEmail = false;
$errorMessagePassword = false;
$hasError = false;

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $name = $_POST['name'];
    $surname = $_POST['surname'];
    $email = $_POST['email'];
    $password = $_POST['password'];
    $confirmPassword = $_POST['confirm_password'];

    // Controllo nome
    if ($name == "") {
        $errorMessageName = true;
        $hasError = true;
    }

    // Controllo cognome
    if ($surname == "") {
        $errorMessageSurname = true;
        $hasError = true;
    }

    // Controllo email
    if ($email == "") {
        $errorMessageEmail = true;
        $hasError = true;
    }

    // Controllo password
    if ($password == "" || $confirmPassword == "" || $password != $confirmPassword) {
        $errorMessagePassword = true;
        $hasError = true;
    }

    // Se tutto ok, registra
    if (!$hasError) {
        $connector = new DbConnector('localhost', 'root', 'root', 'marathon');
        
        // Controlla se email esiste già
        $stmt = $connector->prepare("SELECT id FROM users WHERE email = :email");
        $stmt->execute([':email' => $email]);
        
        if ($stmt->fetch()) {
            $errorMessageEmail = true;
            $hasError = true;
        } else {
            // Inserisci nuovo utente
            $hashPassword = password_hash($password, PASSWORD_BCRYPT);
            
            $stmt = $connector->prepare("INSERT INTO users (name, surname, email, password) VALUES (:name, :surname, :email, :password)");
            $stmt->execute([
                ':name' => $name,
                ':surname' => $surname,
                ':email' => $email,
                ':password' => $hashPassword
            ]);
            
            header('Location: login.php');
            exit;
        }
    }
}
?>

<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link rel="stylesheet" href="login.css">
    <title>MARATHON - Registrazione</title>
    <style>
        body.login {
            margin: 0;
            background: #0f0f1a;
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            min-height: 100vh;
            padding-top: 80px;
            color: #ffffff;
        }

        .login-card {
            width: 340px;
            background: rgba(255,255,255,0.03);
            border: 1px solid #2a2a4a;
            border-radius: 12px;
            padding: 30px;
        }

        .login-title {
            font-size: 26px;
            font-weight: bold;
            text-align: center;
            margin-bottom: 25px;
        }

        .input-group {
            margin-bottom: 16px;
        }

        .input-field {
            width: 100%;
            padding: 10px;
            border-radius: 6px;
            border: 1px solid #2a2a4a;
            background: #1a1a2e;
            color: #ffffff;
            font-size: 14px;
            box-sizing: border-box;
        }

        .input-field:focus {
            outline: none;
            border-color: #8ab4f8;
        }

        .error {
            color: #ff6b6b;
            font-size: 12px;
            margin-top: 5px;
        }

        .register-button {
            width: 100%;
            padding: 10px;
            background: #8ab4f8;
            color: #000;
            border: none;
            border-radius: 6px;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.2s;
            margin-top: 10px;
        }

        .register-button:hover {
            background: #a5c8ff;
        }

        .login-footer {
            text-align: center;
            margin-top: 18px;
            font-size: 13px;
            color: #a0a0c0;
        }

        .login-footer a {
            color: #8ab4f8;
            text-decoration: none;
        }

        .login-footer a:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body class="login">
    <form method="post" class="login-card">
        <div style="text-align: center;">
            <img src="photos/logo.png" style="height: 60px; width: auto;" alt="Logo"/>
        </div>
        <div class="login-title">MARATHON</div>

        <div class="input-group">
            <input placeholder="Nome" class="input-field" type="text" name="name"/>
            <?php if ($errorMessageName): ?>
                <div class="error">Nome obbligatorio</div>
            <?php endif; ?>
        </div>

        <div class="input-group">
            <input placeholder="Cognome" class="input-field" type="text" name="surname"/>
            <?php if ($errorMessageSurname): ?>
                <div class="error">Cognome obbligatorio</div>
            <?php endif; ?>
        </div>

        <div class="input-group">
            <input placeholder="Email" class="input-field" type="email" name="email"/>
            <?php if ($errorMessageEmail): ?>
                <div class="error">Email non valida o già registrata</div>
            <?php endif; ?>
        </div>

        <div class="input-group">
            <input placeholder="Password" class="input-field" type="password" name="password"/>
            <?php if ($errorMessagePassword): ?>
                <div class="error">Password non valida o non coincidono</div>
            <?php endif; ?>
        </div>

        <div class="input-group">
            <input placeholder="Conferma Password" class="input-field" type="password" name="confirm_password"/>
        </div>

        <button class="register-button">Registrati</button>

        <div class="login-footer">
            Hai già un account? <br>
            <a href="login.php">Accedi</a>
        </div>
    </form>
</body>
</html>