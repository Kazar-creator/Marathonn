<?php
    require_once 'DbConnector.php';
    session_start();

    $errorMessageEmail = false;
    $errorMessagePassword = false;
    $hasError = false;

    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $email = $_POST['email'];
        $password = $_POST['password'];

        if ($email == "") {
            $errorMessageEmail = true;
            $hasError = true;
        }

        if ($password == "") {
            $errorMessagePassword = true;
            $hasError = true;
        }

        if (!$hasError) {
            $connector = new DbConnector('localhost', 'root', 'root', 'marathon');
            $statement = $connector->prepare('SELECT * FROM users WHERE email = :email');
            $statement->bindParam(':email', $email);
            $statement->execute();
            $result = $statement->fetch(PDO::FETCH_ASSOC);

            if (empty($result)) {
                $errorMessageEmail = true;
            } else {
                if (password_verify($password, $result['password'])) {

    // SE NON HA AVATAR → assegnalo random
                if (empty($result['avatar'])) {

                    $avatars = [
                        'aliencat2.jpg',
                        'angry.jpg',
                        'caty.jpg',
                        'chaos.jpg',
                        'download.jpg',
                        'HiddenFeelings.jpg',
                        'mrkitty.jpg',
                        'rigbycat.jpg',
                        'sillycat.jpg'
                    ];

                    $randomAvatar = $avatars[array_rand($avatars)];

                    $update = $connector->prepare("
                        UPDATE users 
                        SET avatar = :avatar 
                        WHERE id = :id
                    ");

                    $update->execute([
                        ':avatar' => $randomAvatar,
                        ':id' => $result['id']
                    ]);

                    // aggiorna variabile locale
                    $result['avatar'] = $randomAvatar;
                }

                $_SESSION['user_id'] = $result['id'];
                $_SESSION['role'] = $result['role'];
                $_SESSION['avatar'] = $result['avatar']; 

                header('Location: index.php');
                exit;
                }
            }
        }
    }
?>

<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link rel="stylesheet" href="login.css">
    <title>MARATHON - Login</title>
    <style>
        body.login {
            margin: 0;
            background: #0f0f1a;
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: flex-start;   /* 👈 invece di center */
            min-height: 100vh;
            padding-top: 80px;         /* 👈 regola questo valore */
            color: #ffffff;
        }

        .login-card {
            width: 320px;
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
            margin-bottom: 18px;
        }

        .input-field {
            width: 100%;
            padding: 10px;
            border-radius: 6px;
            border: 1px solid #2a2a4a;
            background: #1a1a2e;
            color: #ffffff;
            font-size: 14px;
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

        .login-button {
            width: 100%;
            padding: 10px;
            background: #8ab4f8;
            color: #000;
            border: none;
            border-radius: 6px;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.2s;
        }

        .login-button:hover {
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
        <img src="photos/logo.png" style="height: 60px; width: auto;"/>
        <div class="login-title">MARATHON</div>

        <div class="input-group">
            <input placeholder="Email" class="input-field" type="email" name="email"/>
            <?php if ($errorMessageEmail): ?>
                <div class="error">Email non valida</div>
            <?php endif; ?>
        </div>

        <div class="input-group">
            <input placeholder="Password" class="input-field" type="password" name="password"/>
            <?php if ($errorMessagePassword): ?>
                <div class="error">Password non valida</div>
            <?php endif; ?>
        </div>

        <button class="login-button">Login</button>

        <div class="login-footer">
            Non sei registrato? <br>
            <a href="register.php">Registrati qui</a>
        </div>
    </form>

</body>
</html>