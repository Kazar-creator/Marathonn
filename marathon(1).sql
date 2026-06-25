-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Creato il: Mag 05, 2026 alle 13:40
-- Versione del server: 8.4.3
-- Versione PHP: 8.3.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `marathon`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `media`
--

CREATE TABLE `media` (
  `id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `type` enum('movie','show','anime') NOT NULL,
  `year_pub` year DEFAULT NULL,
  `total_seasons` int DEFAULT '1',
  `cast` varchar(500) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `poster_url` varchar(255) DEFAULT NULL,
  `genres` varchar(255) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dump dei dati per la tabella `media`
--

INSERT INTO `media` (`id`, `title`, `type`, `year_pub`, `total_seasons`, `cast`, `description`, `poster_url`, `genres`, `deleted_at`) VALUES
(1, 'Breaking Bad', 'show', '2008', 5, 'Bryan Cranston, Aaron Paul, Anna Gunn', 'Walter White, un anonimo professore di chimica, scopre di avere un cancro terminale. Per assicurare il futuro economico della sua famiglia, decide di sfruttare le sue conoscenze scientifiche per produrre la metanfetamina più pura del mercato, trasformandosi nel pericoloso trafficante noto come Heisenberg.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/ggFHVNu6YYI5L9pCfOacjizRGt.jpg', 'Drama, Crime', NULL),
(2, 'Il Padrino', 'movie', '1972', 1, 'Marlon Brando, Al Pacino, James Caan', 'Don Vito Corleone è il capo di una potente famiglia mafiosa a New York. Quando un attentato lo mette fuori gioco, il figlio Michael, inizialmente estraneo agli affari di famiglia, si ritrova risucchiato in una spirale di violenza, vendetta e potere per proteggere l onore dei Corleone.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/gemuM3FvVaWSEBrfk6nVFIOBhBY.jpg', 'Drama, Crime', NULL),
(3, 'Attack on Titan', 'anime', '2013', 4, 'Yuki Kaji, Marina Inoue, Yui Ishikawa', 'In un mondo post-apocalittico, i pochi sopravvissuti dell umanità vivono all interno di tre enormi mura per proteggersi dai Titani, giganti mangiatori di uomini. La pace viene interrotta quando un Titano Colossale distrugge il muro esterno, costringendo il giovane Eren Yeager a giurare vendetta.', 'https://image.tmdb.org/t/p/w500/hTP1DtLGFamjfu8WqjnuQdP1n4i.jpg', 'Action, Sci-Fi, Adventure', NULL),
(4, 'Inception', 'movie', '2010', 1, 'Leonardo DiCaprio, Joseph Gordon-Levitt, Elliot Page', 'Dom Cobb è un estrattore esperto nel rubare segreti dalle menti delle persone mentre sognano. Gli viene offerta la possibilità di cancellare i suoi reati se riesce a compiere l operazione inversa: l inception, ovvero innestare un idea nel subconscio di un bersaglio senza che questi se ne accorga.', 'https://image.tmdb.org/t/p/w500/ljsZTbVsrQSqZgWeep2B1QiDKuh.jpg', 'Sci-Fi, Action, Thriller', NULL),
(5, 'Death Note', 'anime', '2006', 1, 'Mamoru Miyano, Brad Swaile, Shido Nakamura', 'Light Yagami è uno studente modello cinico e annoiato. La sua vita cambia quando trova il Death Note, un quaderno appartenente a un dio della morte che permette di uccidere chiunque scrivendone il nome. Light decide di ripulire il mondo dai criminali, diventando un giustiziere divino chiamato Kira.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/iigTJJskR1PcjjXqxdyJwVB3BoU.jpg\r\n', 'Animation, Crime, Mystery', NULL),
(6, 'Stranger Things', 'show', '2016', 4, 'Millie Bobby Brown, Finn Wolfhard, David Harbour', 'Ambientata negli anni 80 in una cittadina dell Indiana, la serie segue la misteriosa sparizione di un bambino e l apparizione di una ragazzina dotata di poteri telecinetici. Tra esperimenti governativi segreti e una dimensione parallela oscura, i protagonisti dovranno affrontare orrori inimmaginabili.', 'https://image.tmdb.org/t/p/w500/49WJfeN0moxb9IPfGn8AIqMGskD.jpg', 'Sci-Fi, Horror, Drama', NULL),
(7, 'The Last of Us', 'show', '2023', 2, 'Pedro Pascal, Bella Ramsey, Gabriel Luna', 'Vent anni dopo la distruzione della civiltà moderna a causa di un fungo parassita, Joel viene assunto per scortare la quattordicenne Ellie fuori da una zona di quarantena. Quello che inizia come un semplice lavoro si trasforma in un viaggio brutale e straziante attraverso gli Stati Uniti.', 'https://image.tmdb.org/t/p/w500/uKvVjHNqB5VmOrdxqAt2F7J78ED.jpg', 'Action, Adventure, Drama', NULL),
(8, 'The Boys', 'show', '2019', 4, 'Karl Urban, Jack Quaid, Antony Starr', 'Un gruppo di vigilanti combatte supereroi corrotti e potenti.', 'https://image.tmdb.org/t/p/w500/stTEycfG9928HYGEISBFaG1ngjM.jpg', 'Action, Comedy, Crime', NULL),
(9, 'Peaky Blinders', 'show', '2013', 6, 'Cillian Murphy, Helen McCrory, Paul Anderson', 'Le vicende di una gang criminale nella Birmingham del dopoguerra.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/cGVc2oI73UnRfFlx6zKolTnxUA3.jpg', 'Drama, Romance', NULL),
(10, 'The Wire', 'show', '2002', 5, 'Dominic West, Idris Elba, Lance Reddick', 'Un ritratto crudo della criminalita e delle istituzioni di Baltimora.', 'https://image.tmdb.org/t/p/w500/4lbclFySvugI51fwsyxBTOm4DqK.jpg', 'Drama, Music', NULL),
(11, 'Interstellar', 'movie', '2014', 1, 'Matthew McConaughey, Anne Hathaway, Jessica Chastain', 'Un gruppo di astronauti viaggia oltre i confini della galassia per salvare lumanita.', 'https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg', 'Sci-Fi, Adventure, Drama', NULL),
(12, 'The Dark Knight', 'movie', '2008', 1, 'Christian Bale, Heath Ledger, Aaron Eckhart', 'Batman affronta il Joker, un criminale caotico che vuole distruggere Gotham.', 'https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg', 'Action, Crime, Drama', NULL),
(13, 'Pulp Fiction', 'movie', '1994', 1, 'John Travolta, Samuel L. Jackson, Uma Thurman', 'Storie intrecciate di criminali, boxeur e gangster nella Los Angeles underground.', 'https://image.tmdb.org/t/p/w500/d5iIlFn5s0ImszYzBPb8JPIfbXD.jpg', 'Animation, Adventure, Family', NULL),
(14, 'Schindlers List', 'movie', '1993', 1, 'Liam Neeson, Ben Kingsley, Ralph Fiennes', 'La storia vera di Oskar Schindler che salvo oltre mille ebrei durante lOlocausto.', 'https://image.tmdb.org/t/p/w500/sF1U4EUQS8YHUYjNl3pMGNIQyr0.jpg', 'Biography, Drama, History', NULL),
(15, 'Fullmetal Alchemist Brotherhood', 'anime', '2009', 1, 'Romi Park, Rie Kugimiya, Shinichiro Miki', 'Due fratelli cercano la Pietra Filosofale per recuperare i loro corpi perduti.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/5ZFUEOULaVml7pQuXxhpR2SmVUw.jpg\r\n', 'Animation, Action, Adventure', NULL),
(16, 'Demon Slayer', 'anime', '2019', 4, 'Natsuki Hanae, Akari Kito, Yoshitsugu Matsuoka', 'Un ragazzo diventa un cacciatore di demoni per salvare sua sorella trasformata.', 'https://image.tmdb.org/t/p/w500/xUfRZu2mi8jH6SzQEJGP6tjBuYj.jpg', 'Comedy, Drama', NULL),
(17, 'One Piece', 'anime', '1999', 21, 'Mayumi Tanaka, Kazuya Nakai, Akemi Okamura', 'Monkey D. Luffy esplora i mari per trovare il tesoro supremo e diventare Re dei Pirati.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/dB4EDhre2dsC2kxYDavyKWqLQwi.jpg', 'Comedy, Romance', NULL),
(18, 'Naruto Shippuden', 'anime', '2007', 21, 'Junko Takeuchi, Chie Nakamura, Showtaro Morikubo', 'Naruto cresce come ninja e affronta nemici sempre piu potenti per proteggere i suoi cari.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/71mASgFgSiPl9QUexVH8BubU0lD.jpg', 'Drama, Thriller', NULL),
(19, 'Forrest Gump', 'movie', '1994', 1, 'Tom Hanks, Robin Wright, Gary Sinise', 'La vita straordinaria di un uomo dal cuore semplice attraverso la storia americana.', 'https://image.tmdb.org/t/p/w500/arw2vcBveWOVZr6pxd9XTd1TdQa.jpg', 'Horror, Sci-Fi', NULL),
(20, 'The Shawshank Redemption', 'movie', '1994', 1, 'Tim Robbins, Morgan Freeman, Bob Gunton', 'Un banchiere innocente sopravvive anni di ingiustizia in un carcere di massima sicurezza.', 'https://image.tmdb.org/t/p/w500/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg', 'Action, Adventure, Fantasy', NULL),
(21, 'Game of Thrones', 'show', '2011', 8, 'Emilia Clarke, Kit Harington, Peter Dinklage', 'Nobili famiglie si combattono per il controllo dei Sette Regni di Westeros.', 'https://image.tmdb.org/t/p/w500/1XS1oqL89opfnbLl8WnZY1O1uJx.jpg', 'Adventure, Drama, Fantasy', NULL),
(22, 'The Sopranos', 'show', '1999', 6, 'James Gandolfini, Edie Falco, Lorraine Bracco', 'Un boss della mafia del New Jersey affronta la vita familiare e criminale tra crisi esistenziali.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/57okJJUBK0AaijxLh3RjNUaMvFI.jpg', 'Crime, Drama, Mystery', NULL),
(23, 'Black Mirror', 'show', '2011', 6, 'various', 'Antologia distopica che esplora il lato oscuro della tecnologia moderna.', 'https://image.tmdb.org/t/p/w500/7PRddO7z7mcPi21nZTCMGShAyy1.jpg', 'Drama, Sci-Fi', NULL),
(24, 'Chernobyl', 'show', '2019', 1, 'Jared Harris, Stellan Skarsgard, Emily Watson', 'La storia vera del disastro nucleare di Chernobyl e dei suoi protagonisti.', 'https://image.tmdb.org/t/p/w500/hlLXt2tOPT6RRnjiUmoxyG1LTFi.jpg', 'Drama, History, Thriller', NULL),
(25, 'True Detective', 'show', '2014', 4, 'Matthew McConaughey, Woody Harrelson, Mahershala Ali', 'Detective tormentati indagano su crimini oscuri nel profondo Sud americano.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/zYqVTiHK5ZajYcNzAW7qWte5NWS.jpg', 'Crime, Drama, Mystery', NULL),
(26, 'Squid Game', 'show', '2021', 2, 'Lee Jung-jae, Park Hae-soo, Wi Ha-jun', 'Centinaia di persone disperate partecipano a giochi mortali per vincere un premio enorme.', 'https://image.tmdb.org/t/p/w500/dDlEmu3EZ0Pgg93K2SVNLCjCSvE.jpg', 'Comedy, Drama', NULL),
(27, 'House of the Dragon', 'show', '2022', 2, 'Paddy Considine, Emma D Arcy, Matt Smith', 'La storia della casata Targaryen e della guerra civile che la distrusse.', 'https://image.tmdb.org/t/p/w500/z2yahl2uefxDCl0nogcRBstwruJ.jpg', 'Comedy, Drama', NULL),
(28, 'Severance', 'show', '2022', 2, 'Adam Scott, Zach Cherry, Britt Lower', 'Dipendenti di una azienda hanno i ricordi del lavoro separati da quelli della vita privata.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/pPHpeI2X1qEd1CS1SeyrdhZ4qnT.jpg', 'Comedy', NULL),
(29, 'The Bear', 'show', '2022', 3, 'Jeremy Allen White, Ebon Moss-Bachrach, Ayo Edebiri', 'Uno chef stellato torna a Chicago per gestire il ristorante di famiglia dopo una tragedia.', 'https://image.tmdb.org/t/p/w500/sHFlbKS3WLqMnp9t2ghADIJFnuQ.jpg', 'Drama', NULL),
(30, 'Gladiator', 'movie', '2000', 1, 'Russell Crowe, Joaquin Phoenix, Connie Nielsen', 'Un generale romano tradito diventa gladiatore per vendicarsi dell imperatore corrotto.', 'https://image.tmdb.org/t/p/w500/ty8TGRuvJLPUmAR1H1nRIsgwvim.jpg', 'Comedy, Drama', NULL),
(31, 'The Matrix', 'movie', '1999', 1, 'Keanu Reeves, Laurence Fishburne, Carrie-Anne Moss', 'Un hacker scopre che la realta e una simulazione controllata dalle macchine.', 'https://image.tmdb.org/t/p/w500/f89U3ADr1oiB1s9GkdPOEpXUk5H.jpg', 'Action, Sci-Fi', NULL),
(32, 'Goodfellas', 'movie', '1990', 1, 'Ray Liotta, Robert De Niro, Joe Pesci', 'Ascesa e caduta di un gangster nella mafia italoamericana di New York.', 'https://image.tmdb.org/t/p/w500/aKuFiU82s5ISJpGZp7YkIr3kCUd.jpg', 'Action, Sci-Fi', NULL),
(33, 'Fight Club', 'movie', '1999', 1, 'Brad Pitt, Edward Norton, Helena Bonham Carter', 'Un impiegato insoddisfatto fonda un club clandestino di combattimento con un misterioso straniero.', 'https://image.tmdb.org/t/p/w500/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg', 'Drama, Thriller', NULL),
(34, 'The Silence of the Lambs', 'movie', '1991', 1, 'Jodie Foster, Anthony Hopkins, Scott Glenn', 'Una agente FBI chiede aiuto al cannibale Hannibal Lecter per catturare un serial killer.', 'https://image.tmdb.org/t/p/w500/uS9m8OBk1A8eM9I042bx8XXpqAq.jpg', 'Crime, Drama', NULL),
(35, 'No Country for Old Men', 'movie', '2007', 1, 'Tommy Lee Jones, Javier Bardem, Josh Brolin', 'Un uomo trova una valigia piena di soldi e viene inseguito da un killer spietato.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/6d5XOczc226jECq0LIX0siKtgHR.jpg', 'Drama, Romance', NULL),
(36, 'Parasite', 'movie', '2019', 1, 'Song Kang-ho, Lee Sun-kyun, Cho Yeo-jeong', 'Una famiglia povera si infiltra nella vita di una famiglia ricca con conseguenze devastanti.', 'https://image.tmdb.org/t/p/w500/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg', 'Comedy, Drama, Thriller', NULL),
(37, 'Oppenheimer', 'movie', '2023', 1, 'Cillian Murphy, Emily Blunt, Robert Downey Jr.', 'La storia del fisico che guido il progetto Manhattan e creo la prima bomba atomica.', 'https://image.tmdb.org/t/p/w500/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg', 'Action, Sci-Fi', NULL),
(38, '1917', 'movie', '2019', 1, 'George MacKay, Dean-Charles Chapman, Mark Strong', 'Due soldati britannici devono attraversare le linee nemiche per consegnare un messaggio cruciale.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/AuGiPiGMYMkSosOJ3BQjDEAiwtO.jpg', 'Action, Sci-Fi', NULL),
(39, 'Whiplash', 'movie', '2014', 1, 'Miles Teller, J.K. Simmons, Melissa Benoist', 'Un giovane batterista viene spinto oltre i limiti da un insegnante ossessionato dalla perfezione.', 'https://image.tmdb.org/t/p/w500/7fn624j5lj3xTme2SgiLCeuedmO.jpg', 'Drama, Music', NULL),
(40, 'Hunter x Hunter', 'anime', '2011', 6, 'Megumi Han, Mariya Ise, Cristina Valenzuela', 'Un ragazzo parte alla ricerca del padre diventando un Hunter e affrontando pericoli mortali.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/43wEsSJxuV8SZuipKpolOsuGVRZ.jpg', 'Animation, Action, Fantasy', NULL),
(41, 'Steins Gate', 'anime', '2011', 2, 'Mamoru Miyano, Asami Imai, Kana Hanazawa', 'Un giovane scienziato scopre per caso come inviare messaggi nel passato con conseguenze devastanti.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/cBDp3fzX7HhoPxGvKjDrjIwYWJC.jpg', 'Animation, Sci-Fi, Thriller', NULL),
(42, 'Vinland Saga', 'anime', '2019', 2, 'Yuto Uemura, Naoya Uchida, Hiroki Yasumoto', 'Un giovane vichingo cerca vendetta per la morte del padre tra battaglie e conquiste.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/vUHlpA5c1NXkds59reY3HMb4Abs.jpg', 'Animation, Action, Adventure', NULL),
(43, 'Cowboy Bebop', 'anime', '1998', 1, 'Koichi Yamadera, Unsho Ishizuka, Megumi Hayashibara', 'Una crew di cacciatori di taglie viaggia per il sistema solare in cerca di criminali e riscatto.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/xDiXDfZwC6XYC6fxHI1jl3A3Ill.jpg', 'Animation, Action, Sci-Fi', NULL),
(44, 'Neon Genesis Evangelion', 'anime', '1995', 1, 'Megumi Ogata, Megumi Hayashibara, Yuko Miyamura', 'Adolescenti pilotano giganteschi robot per combattere misteriosi esseri chiamati Angeli.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/rZLWgGcMGL0dCdIxRwcfOweTdA5.jpg', 'Animation, Action, Sci-Fi', NULL),
(45, 'Jujutsu Kaisen', 'anime', '2020', 3, 'Junya Enoki, Yuma Uchida, Asami Seto', 'Uno studente ingerisce un dito maledetto e viene introdotto nel mondo degli esorcisti.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/mJVUZpPR4BdZzLWyP51h8pOU1RO.jpg', 'Animation, Action, Fantasy', NULL),
(46, 'Dune', 'movie', '2021', 1, 'Timothée Chalamet, Zendaya, Oscar Isaac', 'Paul Atreides si unisce ai Fremen del pianeta desertico Arrakis per guidare una ribellione contro l\'imperatore.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/cDbNAY0KM84cxXhmj8f0dLWza3t.jpg', 'Sci-Fi, Adventure', NULL),
(47, 'The Godfather Part II', 'movie', '1974', 1, 'Al Pacino, Robert De Niro, Diane Keaton', 'Michael Corleone consolida il potere mentre si esplora l\'ascesa di Vito Corleone.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/jftmAcdl5D94eANbhHugbUJDULI.jpg', 'Drama, Crime', NULL),
(48, 'Arcane', 'show', '2021', 1, 'Hailee Steinfeld, Ella Purnell', 'Due sorelle divise dalle classi sociali di Piltover e Zaun in un conflitto epico.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/zO5xURaYgMX6WpXolp83zVk03Yh.jpg', 'Animation, Action, Drama', NULL),
(49, 'LOTR: Fellowship of the Ring', 'movie', '2001', 1, 'Elijah Wood, Ian McKellen, Viggo Mortensen', 'Frodo intraprende un viaggio per distruggere l\'Anello del Potere.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/6oom5QYQ2yQTMJIbnvbkBL9cHo6.jpg', 'Adventure, Fantasy', NULL),
(50, 'Succession', 'show', '2018', 4, 'Brian Cox, Jeremy Strong, Sarah Snook', 'La famiglia Roy lotta per il controllo dell\'impero mediatico.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/z0XiwdrCQ9yVIr4O0pxzaAYRxdW.jpg', 'Drama', NULL),
(51, 'Your Name', 'anime', '2016', 1, 'Ryunosuke Kamiki, Mone Kamishiraishi', 'Due adolescenti si scambiano i corpi e si cercano nel tempo.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/q719jXXEzOoYaps6babgKnONONX.jpg', 'Animation, Romance, Drama', NULL),
(52, 'Mad Max: Fury Road', 'movie', '2015', 1, 'Tom Hardy, Charlize Theron', 'Max e Furiosa in una corsa post-apocalittica.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/hA2ple9q4qnwxp3hKVNhroipsir.jpg', 'Action, Adventure, Sci-Fi', NULL),
(53, 'The Mandalorian', 'show', '2019', 3, 'Pedro Pascal', 'Cacciatore di taglie protegge Baby Yoda.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/sWgBv7LV2PRoQgkxwlibdGXKz1S.jpg', 'Action, Adventure, Sci-Fi', NULL),
(54, 'Spirited Away', 'anime', '2001', 1, 'Rumi Hiiragi, Miyu Irino', 'Chihiro nel mondo degli spiriti per salvare i genitori.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/39wmItIWsg5sZMyRUHLkWBcuVCM.jpg', 'Animation, Adventure, Family', NULL),
(55, 'The Crown', 'show', '2016', 6, 'Claire Foy, Olivia Colman', 'Vita della regina Elisabetta II.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/1M876KPjulVwppEpldhdc8V4o68.jpg', 'Drama, Biography, History', NULL),
(56, 'Vikings', 'show', '2013', 6, 'Travis Fimmel, Katheryn Winnick, Clive Standen', 'Le saghe dei vichinghi Ragnar Lothbrok e la sua famiglia attraverso razzie e conquiste.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/bQLrHIRNEkE3PdIWQrZHynQZazu.jpg', 'Action, Drama, History', NULL),
(57, 'Erased', 'anime', '2016', 1, 'Shinnosuke Mitsushima, Aoi Yuki', 'Satoru viaggia nel tempo per prevenire omicidi dalla sua infanzia.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/EljUwZJhpuYfVuSfqY8Pt1xxpH.jpg', 'Animation, Drama, Mystery', NULL),
(58, 'Violet Evergarden', 'anime', '2018', 1, 'Yui Ishikawa, Takehito Koyasu', 'Violet, ex soldato, impara le emozioni scrivendo lettere per altri.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/61EwFPqc0r1uJo6la49J55F8bQ8.jpg', 'Animation, Drama, Fantasy', NULL),
(59, 'A Silent Voice', 'anime', '2017', 1, 'Miyu Irino, Saori Hayami', 'Un bullo sordo cerca redenzione dalla sua vittima.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/drlyoSKDOPnxzJFrRWGqzDsyJvR.jpg', 'Animation, Drama', NULL),
(60, 'Better Call Saul', 'show', '2015', 6, 'Bob Odenkirk, Rhea Seehorn', 'L\'avvocato Saul Goodman prima di Breaking Bad.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/zjg4jpK1Wp2kiRvtt5ND0kznako.jpg', 'Crime, Drama', NULL),
(61, 'The Last Kingdom', 'show', '2015', 5, 'Alexander Dreymon, Emily Cox', 'Saga vichinga in Inghilterra con Uhtred.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/8eJf0hxgIhE6QSxbtuNCekTddy1.jpg', 'Action, Drama, History', NULL),
(63, 'Fate/Zero', 'anime', '2011', 2, 'Ayako Kawasumi, Noriaki Sugiyama', 'Guerra per il Santo Graal tra maghi.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/wQwddOBcaLhlyRs0j99XOzGtccm.jpg', 'Animation, Action, Fantasy', NULL),
(64, 'Clannad: After Story', 'anime', '2008', 1, 'Nagisa Furukawa, Tomoya Okazaki', 'Sequel emozionante su vita adulta e famiglia.', 'https://image.tmdb.org/t/p/w500/5ZFUEOULaVml7pQuXxhpR2SmVUw.jpg', 'Animation, Drama, Romance', NULL),
(65, 'One Punch Man', 'anime', '2015', 2, 'Makoto Furukawa, Kaito Ishikawa', 'Saitama sconfigge tutti con un pugno.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/3yvPziuLr2lT6DGP3M0jO7yjBVt.jpg', 'Animation, Action, Comedy', NULL),
(66, 'Puella Magi Madoka Magica', 'anime', '2011', 1, 'Aoi Yuuki, Chiwa Saito', 'Bambine magiche in un mondo oscuro.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/9Leopb4OB9j9FkP5JNHRZZlPPdg.jpg', 'Animation, Drama, Mystery', NULL),
(67, 'Toradora!', 'anime', '2008', 1, 'Ryuuji Takasu, Taiga Aisaka', 'Romcom tsundere classica.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/gUE1zdXPkEBdEUtmJ2rkcGON41s.jpg', 'Animation, Comedy, Romance', NULL),
(68, 'Noragami', 'anime', '2014', 2, 'Hiroshi Kamiya, Maaya Uchida', 'Dio errante combatte spiriti.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/7pL2wGmy92v31ceYvCVIg4ilwLr.jpg', 'Animation, Action, Adventure', NULL),
(69, 'Black Butler', 'anime', '2008', 4, 'Yuya Matsushita, Brina Palencia', 'Maggiordomo demoniaco serve nobile vittoriano.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/iXGs130TRoUplHf0o86zp9MqAYc.jpg', 'Animation, Action, Comedy', NULL),
(70, 'Fruits Basket', 'anime', '2019', 3, 'Manaka Iwami, Nobunaga Shimazaki', 'Ragazza maledetta dai 12 animali zodiacali.', 'https://image.tmdb.org/t/p/w500/vUHlpA5c1NXkds59reY3HMb4Abs.jpg', 'Animation, Comedy, Drama', NULL),
(71, 'Shrek', 'movie', '2001', 1, 'Mike Myers, Eddie Murphy, Cameron Diaz', 'Un orco solitario vede la sua vita invasa da creature fiabesche e fa un patto con un arrogante signore per riavere la sua palude.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/o04jZs5SXhbvhqO4981W7KJXOWZ.jpg', 'Animation, Comedy, Adventure', NULL),
(72, 'Barbie', 'movie', '2023', 1, 'Margot Robbie, Ryan Gosling, America Ferrera', 'Barbie e Ken vivono nel colorato mondo di Barbie Land, ma una crisi esistenziale li porta nel mondo reale.', 'https://image.tmdb.org/t/p/w500/iuFNMS8U5cb6xfzi51Dbkovj7vM.jpg', 'Comedy, Adventure, Fantasy', NULL),
(73, 'Oppenheimer', 'movie', '2023', 1, 'Cillian Murphy, Emily Blunt, Robert Downey Jr.', 'La storia del fisico J. Robert Oppenheimer e il suo ruolo nello sviluppo della bomba atomica.', 'https://image.tmdb.org/t/p/w500/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg', 'Drama, History, Biography', NULL),
(74, 'John Wick: Chapter 4', 'movie', '2023', 1, 'Keanu Reeves, Donnie Yen, Bill Skarsgård', 'John Wick scopre una strada per sconfiggere la Tavola Alta, ma la libertà ha un prezzo.', 'https://image.tmdb.org/t/p/w500/vZloFAK7NmvMGKE7VkF5UHaz0I.jpg', 'Action, Thriller, Crime', NULL),
(75, 'Everything Everywhere All at Once', 'movie', '2022', 1, 'Michelle Yeoh, Stephanie Hsu, Ke Huy Quan', 'Una donna cinese immigrata negli USA scopre di dover salvare il mondo viaggiando tra universi paralleli.', 'https://image.tmdb.org/t/p/w500/w3LxiVYdWWRvEVdn5RYq6jIqkb1.jpg', 'Action, Adventure, Sci-Fi', NULL),
(76, 'Top Gun: Maverick', 'movie', '2022', 1, 'Tom Cruise, Miles Teller, Jennifer Connelly', 'Maverick torna nella Marina per addestrare una nuova generazione di piloti per una missione impossibile.', 'https://image.tmdb.org/t/p/w500/62HCnUTziyWcpDaBO2i1DX17ljH.jpg', 'Action, Drama', NULL),
(77, 'The Batman', 'movie', '2022', 1, 'Robert Pattinson, Zoë Kravitz, Paul Dano', 'Batman esplora la corruzione di Gotham City mentre dà la caccia a un misterioso killer.', 'https://image.tmdb.org/t/p/w500/74xTEgt7R36Fpooo50r9T25onhq.jpg', 'Crime, Drama, Mystery', NULL),
(78, 'Dune: Part Two', 'movie', '2024', 1, 'Timothée Chalamet, Zendaya, Austin Butler', 'Paul Atreides si unisce ai Fremen in una guerra per vendicare la sua famiglia e salvare l\'universo.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/6izwz7rsy95ARzTR3poZ8H6c5pp.jpg', 'Sci-Fi, Adventure', NULL),
(79, 'Spider-Man: Across the Spider-Verse', 'movie', '2023', 1, 'Shameik Moore, Hailee Steinfeld, Oscar Isaac', 'Miles Morales si riunisce con Gwen Stacy in un viaggio attraverso il multiverso.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/8Vt6mWEReuy4Of61Lnj5Xj704m8.jpg', 'Animation, Action, Adventure', NULL),
(80, 'The Whale', 'movie', '2022', 1, 'Brendan Fraser, Sadie Sink, Hong Chau', 'Un professore obeso cerca di riconnettersi con la figlia adolescente.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/ken2sQbCqZuAYmgPknrChXvkrEK.jpg', 'Drama', NULL),
(81, 'Avatar: The Way of Water', 'movie', '2022', 1, 'Sam Worthington, Zoe Saldaña, Sigourney Weaver', 'Jake e Neytiri proteggono la loro famiglia mentre affrontano una nuova minaccia.', 'https://image.tmdb.org/t/p/w500/t6HIqrRAclMCA60NsSmeqe9RmNV.jpg', 'Sci-Fi, Adventure', NULL),
(82, 'Glass Onion', 'movie', '2022', 1, 'Daniel Craig, Edward Norton, Janelle Monáe', 'Il detective Benoit Blanc indaga su un omicidio in Grecia.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/vDGr1YdrlfbU9wxTOdpf3zChmv9.jpg', 'Comedy, Crime, Mystery', NULL),
(83, 'Knives Out', 'movie', '2019', 1, 'Daniel Craig, Chris Evans, Ana de Armas', 'Un detective indaga sulla morte del patriarca di una famiglia eccentrica.', 'https://image.tmdb.org/t/p/w500/pThyQovXQrw2m0s9x82twj48Jq4.jpg', 'Comedy, Crime, Mystery', NULL),
(84, 'The Social Network', 'movie', '2010', 1, 'Jesse Eisenberg, Andrew Garfield, Justin Timberlake', 'La storia della fondazione di Facebook e le battaglie legali che ne seguirono.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/jXbqfVHmvCikyTw2Lf5OhKyt9Ym.jpg', 'Drama, Biography', NULL),
(85, 'The Grand Budapest Hotel', 'movie', '2014', 1, 'Ralph Fiennes, Tony Revolori, Saoirse Ronan', 'Il concierge di un hotel leggendario viene accusato di omicidio.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/eWdyYQreja6JGCzqHWXpWHDrrPo.jpg', 'Comedy, Drama', NULL),
(86, 'La La Land', 'movie', '2016', 1, 'Ryan Gosling, Emma Stone, John Legend', 'Un musicista e un\'attrice inseguono i loro sogni a Los Angeles.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/ozobdmMlse2FrQtoRhqUHCouSHL.jpg', 'Drama, Music, Romance', NULL),
(87, 'Joker', 'movie', '2019', 1, 'Joaquin Phoenix, Robert De Niro, Zazie Beetz', 'Arthur Fleck, un comico fallito, intraprende una spirale di follia a Gotham City.', 'https://image.tmdb.org/t/p/w500/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg', 'Drama, Thriller, Crime', NULL),
(88, 'The Revenant', 'movie', '2015', 1, 'Leonardo DiCaprio, Tom Hardy, Domhnall Gleeson', 'Un esploratore lotta per sopravvivere dopo essere stato attaccato da un orso.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/ji3ecJphATlVgWNY0B0RVXZizdf.jpg', 'Action, Adventure, Drama', NULL),
(89, 'Django Unchained', 'movie', '2012', 1, 'Jamie Foxx, Christoph Waltz, Leonardo DiCaprio', 'Uno schiavo diventato cacciatore di taglie cerca di salvare sua moglie.', 'https://image.tmdb.org/t/p/w500/7oWY8VDWW7thTzWh3OKYRkWUlD5.jpg', 'Drama, Western', NULL),
(90, 'Inglourious Basterds', 'movie', '2009', 1, 'Brad Pitt, Mélanie Laurent, Christoph Waltz', 'Un gruppo di soldati ebrei pianifica un attentato contro i nazisti.', 'https://image.tmdb.org/t/p/w500/7sfbEnaARXDDhKm0CZ7D7uc2sbo.jpg', 'Action, Drama, War', NULL),
(91, 'Kill Bill: Vol. 1', 'movie', '2003', 1, 'Uma Thurman, Lucy Liu, Vivica A. Fox', 'La Sposa cerca vendetta contro la sua ex squadra di assassini.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/v7TaX8kXMXs5yFFGR41guUDNcnB.jpg', 'Action, Crime, Thriller', NULL),
(92, 'Reservoir Dogs', 'movie', '1992', 1, 'Harvey Keitel, Tim Roth, Michael Madsen', 'Sei criminali si ritrovano dopo una rapina fallita.', 'https://image.tmdb.org/t/p/w500/xi8Iu6qyTfyZVDVy60raIOYJJmk.jpg', 'Crime, Drama, Thriller', NULL),
(93, 'The Hateful Eight', 'movie', '2015', 1, 'Samuel L. Jackson, Kurt Russell, Jennifer Jason Leigh', 'Otto sconosciuti si trovano bloccati in una locanda durante una tempesta di neve.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/jIywvdPjia2t3eKYbjVTcwBQlG8.jpg', 'Crime, Drama, Mystery', NULL),
(94, 'Once Upon a Time in Hollywood', 'movie', '2019', 1, 'Leonardo DiCaprio, Brad Pitt, Margot Robbie', 'Un attore in declino e la sua controfigura navigano nella Hollywood del 1969.', 'https://image.tmdb.org/t/p/w500/8j58iEBw9pOXFD2L0nt0ZXeHviB.jpg', 'Comedy, Drama', NULL),
(95, 'Chainsaw Man', 'anime', '2022', 1, 'Kikunosuke Toya, Tomori Kusunoki, Shogo Sakata', 'Denji fa un patto con il suo demone motosega per diventare un cacciatore di demoni.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/yVtx7Xn9UxNJqvG2BkvhCcmed9S.jpg', 'Animation, Action, Fantasy', NULL),
(96, 'Spy x Family', 'anime', '2022', 2, 'Takuya Eguchi, Atsumi Tanezaki, Saori Hayami', 'Una spia, un\'assassina e una telepate formano una famiglia fittizia.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/7NAvPYPAu7MeHwP8E9sn81PqsRh.jpg', 'Animation, Comedy, Action', NULL),
(97, 'My Hero Academia', 'anime', '2016', 6, 'Daiki Yamashita, Nobuhiko Okamoto, Yuki Kaji', 'In un mondo di superpoteri, un ragazzo senza poteri sogna di diventare un eroe.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/1MBghufuqgZQZZPT2iZq16LfC6U.jpg', 'Animation, Action, Comedy', NULL),
(98, 'Tokyo Revengers', 'anime', '2021', 2, 'Yuu Hayashi, Azumi Waki, Ryota Osaka', 'Un uomo viaggia indietro nel tempo per salvare la sua ex ragazza.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/arB3L9pZZBSzUPSC8BEv8c3X0bF.jpg', 'Animation, Action, Drama', NULL),
(99, 'Mushoku Tensei', 'anime', '2021', 2, 'Yumi Uchiyama, Tomokazu Sugita, Ai Kayano', 'Un uomo reincarnato in un mondo fantasy cerca di vivere una nuova vita senza rimpianti.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/fHXI3fJN0ZOVw2OmLmY2t9VgV83.jpg', 'Animation, Adventure, Fantasy', NULL),
(100, 'Re:Zero', 'anime', '2016', 2, 'Yusuke Kobayashi, Rie Takahashi, Yumi Hara', 'Un ragazzo viene trasportato in un mondo fantasy con il potere di tornare indietro nel tempo morendo.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/5MrRCj7z92YLWMXHeWKp19eJPYv.jpg', 'Animation, Drama, Fantasy', NULL),
(101, 'The Rising of the Shield Hero', 'anime', '2019', 3, 'Kaito Ishikawa, Asami Seto, Rina Hidaka', 'Un giovane viene evocato in un mondo fantasy come Eroe dello Scudo.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/6lc1Snwv1gsYBbT5ZVx7Iv9h2to.jpg', 'Animation, Action, Adventure', NULL),
(102, 'Overlord', 'anime', '2015', 4, 'Satoshi Hino, Yumi Hara, Sumire Uesaka', 'Un giocatore rimane intrappolato nel suo gioco VR insieme alla sua gilda.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/ifBQvwlfd90MfuggjVlAFgITVsm.jpg', 'Animation, Action, Fantasy', NULL),
(103, 'That Time I Got Reincarnated as a Slime', 'anime', '2018', 3, 'Miho Okasaki, Megumi Toyoguchi, Tomoaki Maeno', 'Un uomo viene reincarnato come slime in un mondo fantasy.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/jQb1ztdko9qc4aCdnMXShcIHXRG.jpg', 'Animation, Action, Adventure', NULL),
(104, 'The Eminence in Shadow', 'anime', '2022', 2, 'Seiichiro Yamashita, Rina Hidaka, Asami Seto', 'Un ragazzo sogna di diventare un maestro nell\'ombra in un mondo fantasy.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/7JKYmtLydAwo9ZsEmAknZiO4U8g.jpg', 'Animation, Action, Comedy', NULL),
(105, 'The Last of Us', 'show', '2023', 1, 'Pedro Pascal, Bella Ramsey, Anna Torv', 'Joel deve scortare Ellie attraverso gli Stati Uniti post-apocalittici.', 'https://image.tmdb.org/t/p/w500/uKvVjHNqB5VmOrdxqAt2F7J78ED.jpg', 'Action, Adventure, Drama', NULL),
(106, 'Wednesday', 'show', '2022', 1, 'Jenna Ortega, Emma Myers, Hunter Doohan', 'Wednesday Addams indaga su una serie di omicidi alla Nevermore Academy.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/9PFonBhy4cQy7Jz20NpMygczOkv.jpg', 'Comedy, Fantasy, Mystery', NULL),
(107, 'Dahmer – Monster: The Jeffrey Dahmer Story', 'show', '2022', 1, 'Evan Peters, Richard Jenkins, Molly Ringwald', 'La storia del serial killer Jeffrey Dahmer.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/f2PVrphK0u81ES256lw3oAZuF3x.jpg', 'Crime, Drama', NULL),
(108, 'The Queen\'s Gambit', 'show', '2020', 1, 'Anya Taylor-Joy, Thomas Brodie-Sangster, Harry Melling', 'Una giovane orfana prodigio degli scacchi lotta contro la dipendenza.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/zU0htwkhNvBQdVSIKB9s6hgVeFK.jpg', 'Drama', NULL),
(109, 'The Witcher', 'show', '2019', 3, 'Henry Cavill, Anya Chalotra, Freya Allan', 'Geralt di Rivia, un cacciatore di mostri, naviga in un mondo corrotto.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/1KEheZQ3uiTjXbU4NezKdOiVWEp.jpg', 'Action, Adventure, Fantasy', NULL),
(110, 'Invincible', 'show', '2021', 2, 'Steven Yeun, J.K. Simmons, Sandra Oh', 'Il figlio del supereroe più potente del mondo inizia a sviluppare i suoi poteri.', 'https://image.tmdb.org/t/p/w500/yDWJYRAwMNKbIYT8ZB33qy84uzO.jpg', 'Animation, Action, Sci-Fi', NULL),
(111, 'The Sandman', 'show', '2022', 1, 'Tom Sturridge, Boyd Holbrook, Vivienne Acheampong', 'Il Signore dei Sogni viene catturato e imprigionato per un secolo.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/4euFDlEmu5iRTGb6rnFbafFuf7z.jpg', 'Drama, Fantasy, Horror', NULL),
(112, 'Andor', 'show', '2022', 1, 'Diego Luna, Stellan Skarsgård, Kyle Soller', 'La storia della ribellione che si oppone all\'Impero Galattico.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/khZqmwHQicTYoS7Flreb9EddFZC.jpg', 'Action, Adventure, Sci-Fi', NULL),
(113, 'Star Wars: The Clone Wars', 'show', '2008', 7, 'Matt Lanter, James Arnold Taylor, Ashley Eckstein', 'Le avventure di Anakin Skywalker e Obi-Wan Kenobi durante le Guerre dei Cloni.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/e1nWfnnCVqxS2LeTO3dwGyAsG2V.jpg', 'Animation, Action, Adventure', NULL),
(114, 'Loki', 'show', '2021', 2, 'Tom Hiddleston, Owen Wilson, Sophia Di Martino', 'Loki scappa dopo aver preso il Tesseract.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/voHUmluYmKyleFkTu3lOXQG702u.jpg', 'Action, Adventure, Sci-Fi', NULL),
(115, 'WandaVision', 'show', '2021', 1, 'Elizabeth Olsen, Paul Bettany, Kathryn Hahn', 'Wanda e Visione vivono una vita suburbana perfetta... o quasi.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/frobUz2X5Pc8OiVZU8Oo5K3NKMM.jpg', 'Comedy, Drama, Mystery', NULL),
(116, 'The Falcon and the Winter Soldier', 'show', '2021', 1, 'Anthony Mackie, Sebastian Stan, Wyatt Russell', 'Sam e Bucky affrontano nuove minacce dopo Endgame.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/6kbAMLteGO8yyewYau6bJ683sw7.jpg', 'Action, Adventure, Drama', NULL),
(117, 'Hawkeye', 'show', '2021', 1, 'Jeremy Renner, Hailee Steinfeld, Florence Pugh', 'Clint Barton deve tornare a New York per Natale.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/5BxY6UN0e7wAE5LUQVVj39JAItM.jpg', 'Action, Adventure, Comedy', NULL),
(118, 'Moon Knight', 'show', '2022', 1, 'Oscar Isaac, Ethan Hawke, May Calamawy', 'Un guardiano della notte lotta contro poteri soprannaturali.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/x6FsYvt33846IQnDSFxla9j0RX8.jpg', 'Action, Adventure, Fantasy', NULL),
(119, 'She-Hulk: Attorney at Law', 'show', '2022', 1, 'Tatiana Maslany, Mark Ruffalo, Tim Roth', 'Jennifer Walters diventa l\'avvocato dei supereroi.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/5xz2orV8f0usyrfGNshcoXHmiaV.jpg', 'Comedy, Action, Sci-Fi', NULL),
(120, 'Ms. Marvel', 'show', '2022', 1, 'Iman Vellani, Matt Lintz, Yasmeen Fletcher', 'Una giovane fan dei supereroi scopre di avere poteri.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/ls2Hl8CXmqEHvkDqkN3fRtmDodK.jpg', 'Action, Adventure, Comedy', NULL),
(121, 'Code Geass: Lelouch of the Rebellion', 'anime', '2006', 2, 'Jun Fukuyama, Takahiro Sakurai, Yukana', 'Lelouch vi Britannia, un principe esiliato, ottiene il potere del Geass che gli permette di comandare chiunque. Con questo potere e l\'aiuto di un misterioso gruppo di ribelli chiamato Black Knights, guida una rivoluzione per distruggere l\'impero di Britannia e creare un mondo migliore per sua sorella.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/2cBDhzbP7KOLbWtTzxS4WIDLh70.jpg', 'Animation, Action, Drama, Sci-Fi', NULL),
(122, 'Clannad', 'anime', '2007', 1, 'Yuichi Nakamura, Mai Nakahara, Ryo Hirohashi', 'Tomoya Okazaki è uno studente che non si interessa più della vita scolastica. Un giorno incontra Nagisa Furukawa, una ragazza che ripete l\'anno per malattia. Insieme, cercheranno di ricostruire il club di teatro della scuola, stringendo legami che cambieranno le loro vite per sempre.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/4otZ5XprU2GvVAi6aocU751uIG1.jpg', 'Animation, Drama, Romance', NULL),
(123, 'Monster', 'anime', '2004', 1, 'Hidenobu Kiuchi, Mamiko Noto, Tsutomu Isobe', 'Il dottor Kenzo Tenma salva un bambino invece dell\'uomo importante che avrebbe dovuto operare. Anni dopo, scopre che quel bambino è diventato un mostro chiamato Johan, un serial killer spietato. Tenma intraprende un viaggio per fermare ciò che ha creato.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/n5XNKXnoXpoXyfiCtXHOf8q8PFM.jpg', 'Animation, Crime, Drama, Mystery', NULL),
(124, 'Cyberpunk: Edgerunners', 'anime', '2022', 1, 'Kenjiro Tsuda, Aoi Yuki, Tomoyo Kurosawa', 'David Martinez, uno studente che vive a Night City, decide di diventare un edgerunner (cyberpunk mercenario) dopo una tragedia. Insieme a Lucy e altri fuorilegge, affronterà il lato oscuro della società ipertecnologica e corrotta.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/lqcDVZ8pyk08AVftMBildDR3QUK.jpg', 'Animation, Action, Sci-Fi, Cyberpunk', NULL),
(125, 'Tokyo Ghoul', 'anime', '2014', 4, 'Natsuki Hanae, Sora Amamiya, Shintaro Asanuma', 'Ken Kaneki scopre di essere diventato un ibrido umano-ghoul dopo un incontro violento. Cerca di sopravvivere nel mondo dei ghoul che si nutrono di carne umana, lottando per mantenere la sua umanità.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/mt6ForyKh4JS0v5ho8xhauISidF.jpg', 'Animation, Action, Horror, Drama', NULL),
(126, 'Fairy Tail', 'anime', '2009', 9, 'Tetsuya Kakihara, Aya Hirano, Rie Kugimiya', 'Lucy Heartfilia sogna di entrare nella gilda magica Fairy Tail. Incontra Natsu Dragneel, un cacciatore di draghi, e insieme vivranno avventure epiche, combattendo nemici potenti e difendendo i loro amici con la magia e il legame della gilda.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/AsfCVSHnFnUnbepLucvIB1N30Il.jpg', 'Animation, Action, Adventure, Comedy, Fantasy', NULL),
(127, 'I Want to Eat Your Pancreas', 'anime', '2018', 1, 'Mahiro Takasugi, Lynn, Yukiyo Fujii', 'Un ragazzo solitario trova un diario della sua compagna di classe Sakura Yamauchi, che rivela che sta morendo a causa di una malattia al pancreas. Nonostante la loro differenza, sviluppano un legame unico e prezioso nei giorni che le rimangono.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/qpV8kvRfAntV7D4aOOsLIz7OdPc.jpg', 'Animation, Drama, Romance', NULL),
(128, 'Parasyte: The Maxim', 'anime', '2014', 1, 'Nobunaga Shimazaki, Aya Hirano, Kana Hanazawa', 'Shinichi Izumi diventa ospite di un parassita alieno chiamato Migi che prende il controllo della sua mano destra. Insieme, devono combattere altri parassiti che divorano gli umani, esplorando cosa significa essere umani.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/2ngHwPQhHGPpLkLQd2MTAI3iXPq.jpg', 'Animation, Action, Horror, Sci-Fi', NULL),
(129, 'Bleach', 'anime', '2004', 16, 'Masakazu Morita, Fumiko Orikasa, Hiroki Yasumoto', 'Ichigo Kurosaki ottiene i poteri di uno Shinigami (dio della morte) dopo aver incontrato Rukia Kuchiki. Deve proteggere gli umani dagli Hollow, spiriti maligni, mentre cerca di trovare un equilibrio tra il mondo umano e quello spirituale.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/vdWSv1yyqQLz9POkbUyKEmAkJOM.jpg', 'Animation, Action, Adventure, Fantasy', NULL),
(130, 'JoJo\'s Bizarre Adventure', 'anime', '2012', 6, 'Kazuyuki Okitsu, Tomokazu Sugita, Daisuke Ono', 'La saga della famiglia Joestar attraverso generazioni, combattendo nemici sovrannaturali usando Stand, potenti manifestazioni del proprio spirito. Ogni arco segue un diverso membro della famiglia in avventure bizzarre e combattimenti incredibili.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/2zXHA1uySbliqutZZ95C9lvf2MY.jpg', 'Animation, Action, Adventure, Fantasy', NULL),
(131, 'Gintama', 'anime', '2006', 26, 'Tomokazu Sugita, Daisuke Sakaguchi, Rie Kugimiya', 'In un Giappone alternativo dove gli alieni hanno preso il controllo, Gintoki Sakata lavora come tuttofare insieme ai suoi amici. Tra combattimenti epici e gag assurde, la serie mescola azione, commedia e momenti drammatici.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/v06DypXDQplY3RGs49yywTnFPS2.jpg', 'Animation, Action, Comedy, Sci-Fi', NULL),
(132, 'Mr. Robot', 'show', '2015', 4, 'Rami Malek, Christian Slater, Carly Chaikin', 'Elliot Alderson, un giovane ingegnere informatico con disturbo di personalità, lavora come vigilante informatico di notte. Viene reclutato da un misterioso anarchico noto come Mr. Robot per unirsi alla sua squadra di hacker che mira a cancellare tutti i debiti del mondo.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/6qeKp1SLEp5IoP30KyUPl9ZNquZ.jpg', 'Crime, Drama, Thriller', NULL),
(133, 'Snowfall', 'show', '2017', 6, 'Damson Idris, Carter Hudson, Sergio Peris-Mencheta', 'Los Angeles, 1983. La storia dell\'epidemia di crack che ha colpito la città, vista attraverso gli occhi di Franklin Saint, un giovane venditore di strada che si trasforma in un potente signore della droga.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/oqaDHgXZtxYTaxzC07OTlSLh0P6.jpg', 'Crime, Drama', NULL),
(134, 'Prison Break', 'show', '2005', 5, 'Wentworth Miller, Dominic Purcell, Sarah Wayne Callies', 'Michael Scofield fa incarcerare apposta suo fratello Lincoln, condannato a morte per un crimine che non ha commesso. Il suo piano elaborato: fuggire dal carcere di massima sicurezza insieme a lui.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/j7HFOunuAVpOdiBhXpjwRxIgK5y.jpg', 'Action, Crime, Drama', NULL),
(135, 'Dexter', 'show', '2006', 8, 'Michael C. Hall, Jennifer Carpenter, David Zayas', 'Dexter Morgan è un esperto di sangue per la polizia di Miami, ma di notte è un serial killer che uccide solo altri assassini che sono sfuggiti alla giustizia, seguendo un rigido codice insegnatogli dal padre adottivo.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/q8dWfc4JwQuv3HayIZeO84jAXED.jpg', 'Crime, Drama, Mystery', NULL),
(136, 'The Walking Dead', 'show', '2010', 11, 'Andrew Lincoln, Norman Reedus, Melissa McBride', 'In un mondo post-apocalittico invaso da zombie (chiamati \'camminatori\'), l\'ufficiale di polizia Rick Grimes si risveglia dal coma e guida un gruppo di sopravvissuti nella lotta per la sopravvivenza contro i morti viventi e minacce ancora più pericolose: gli umani.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/s3OIDrCErUjthsnPPreY7XktQXB.jpg', 'Drama, Horror, Thriller', NULL),
(137, 'The 100', 'show', '2014', 7, 'Eliza Taylor, Bob Morley, Marie Avgeropoulos', '97 anni dopo una guerra nucleare che ha distrutto la Terra, 100 giovani delinquenti vengono mandati sulla superficie per vedere se il pianeta è di nuovo abitabile. Devono sopravvivere a un ambiente ostile e a gruppi rivali.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/wcaDIAG1QdXQLRaj4vC1EFdBT2.jpg', 'Drama, Mystery, Sci-Fi', NULL),
(138, 'Outer Banks', 'show', '2020', 4, 'Chase Stokes, Madelyn Cline, Madison Bailey', 'Un gruppo di adolescenti chiamati \'Pogues\' vive sull\'isola di Outer Banks. Iniziano un\'avventura per scoprire il mistero della scomparsa del padre del loro capo, John B, legato a un tesoro perduto.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/ovDgO2LPfwdVRfvScAqo9aMiIW.jpg', 'Action, Drama, Mystery', NULL),
(139, 'Lost', 'show', '2004', 6, 'Matthew Fox, Evangeline Lilly, Josh Holloway', 'I sopravvissuti di un incidente aereo si ritrovano su un\'isola misteriosa nel Pacifico. Devono lottare per sopravvivere e scoprire i segreti dell\'isola, tra cui una bestia misteriosa, un gruppo di altri sopravvissuti chiamati \'Gli Altri\' e una botola nel terreno.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/og6S0aTZU6YUJAbqxeKjCa3kY1E.jpg', 'Adventure, Drama, Mystery, Sci-Fi', NULL),
(140, 'The Legend of Korra', 'show', '2012', 4, 'Janet Varney, David Faustino, P.J. Byrne', 'Korra, l\'Avatar dopo Aang, vive in un mondo che si sta modernizzando rapidamente. Deve padroneggiare gli elementi, affrontare rivoluzionari che odiano i portatori di poteri e combattere spiriti oscuri che minacciano la pace.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/9Lr6uaqNZ3LN6IJKmxpUsWnlT7Y.jpg', 'Animation, Action, Adventure, Fantasy', NULL),
(141, 'Avatar: The Last Airbender', 'show', '2005', 3, 'Zach Tyler Eisen, Mae Whitman, Jack De Sena', 'In un mondo diviso in quattro nazioni (Acqua, Terra, Fuoco e Aria), il giovane Aang è l\'Avatar, l\'unico in grado di padroneggiare tutti e quattro gli elementi. Deve fermare la Nazione del Fuoco dalla conquista del mondo.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/9RQhVb3r3mCMqYVhLoCu4EvuipP.jpg', 'Animation, Action, Adventure, Fantasy', NULL),
(142, 'Dark', 'show', '2017', 3, 'Louis Hofmann, Karoline Eichhorn, Lisa Vicari', 'Nella piccola città tedesca di Winden, la scomparsa di due bambini svela una complessa trama di viaggi nel tempo e connessioni nascoste tra quattro famiglie, che si estende per generazioni.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/apbrbWs8M9lyOpJYU5WXrpFbk1Z.jpg', 'Crime, Drama, Mystery, Sci-Fi', NULL),
(143, 'Narcos', 'show', '2015', 3, 'Wagner Moura, Pedro Pascal, Boyd Holbrook', 'La storia vera della lotta delle forze dell\'ordine contro il potente impero della droga di Pablo Escobar e altri signori della droga colombiani negli anni \'80 e \'90.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/isHoM9LQOYi6VrF4SWrghWCR5H9.jpg', 'Biography, Crime, Drama', NULL),
(144, 'Doctor Who', 'show', '2005', 13, 'Jodie Whittaker, David Tennant, Matt Smith', 'Il Dottore, un alieno viaggiatore del tempo della razza dei Signori del Tempo, esplora l\'universo nel TARDIS, una macchina del tempo dall\'apparenza di una cabina telefonica blu. Insieme ai suoi compagni umani, affronta mostri e salva civiltà.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/xinqAmYrZ1TEwowcQhgTkZVtVE0.jpg', 'Adventure, Drama, Sci-Fi', NULL),
(145, 'Friends', 'show', '1994', 10, 'Jennifer Aniston, Courteney Cox, Lisa Kudrow', 'Sei amici newyorkesi vivono, amano e affrontano la vita adulta insieme. Tra caffè al Central Perk, relazioni complicate e momenti indimenticabili, questa sitcom è diventata un fenomeno culturale.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/f496cm9enuEsZkSPzCwnTESEK5s.jpg', 'Comedy, Romance', NULL),
(146, 'Dead Poets Society', 'movie', '1989', 1, 'Robin Williams, Robert Sean Leonard, Ethan Hawke', 'Un insegnante di inglese anticonformista ispira i suoi studenti di un college maschile attraverso la poesia e il libero pensiero, sfidando le rigide tradizioni della scuola.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/erzbMlcNHOdx24AXOcn2ZKA7R1q.jpg', 'Drama', NULL),
(147, 'Prisoners', 'movie', '2013', 1, 'Hugh Jackman, Jake Gyllenhaal, Viola Davis', 'Quando sua figlia scompare, un padre disperato si prende giustizia da solo, mentre il detective incaricato del caso cerca di risolvere il mistero prima che sia troppo tardi.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/jsS3a3ep2KyBVmmiwaz3LvK49b1.jpg', 'Crime, Drama, Mystery', NULL),
(148, 'Beautiful Boy', 'movie', '2018', 1, 'Steve Carell, Timothée Chalamet, Maura Tierney', 'La storia vera del rapporto tra un padre e suo figlio, alle prese con la dipendenza da metamfetamine.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/u2Gfv0mz3xePsgyCPHovrnFL1sB.jpg', 'Biography, Drama', NULL),
(149, 'Se7en', 'movie', '1995', 1, 'Brad Pitt, Morgan Freeman, Kevin Spacey', 'Due detective di polizia inseguono un serial killer che basa i suoi omicidi sui sette peccati capitali.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/gEJM4psjlW4wb0iav92GRG5Xlug.jpg', 'Crime, Drama, Mystery', NULL),
(150, 'The Maze Runner', 'movie', '2014', 1, 'Dylan O\'Brien, Kaya Scodelario, Will Poulter', 'Un ragazzo si risveglia in un ascensore senza memoria, trovandosi in un labirinto con altri ragazzi che cercano una via d\'uscita.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/17I7Td8YmrJ7u8r1iMJqslpBRmX.jpg', 'Action, Mystery, Sci-Fi', NULL),
(151, 'Maze Runner: The Scorch Trials', 'movie', '2015', 1, 'Dylan O\'Brien, Kaya Scodelario, Thomas Brodie-Sangster', 'Thomas e i suoi compagni devono attraversare un deserto infetto per scoprire i segreti dell\'organizzazione che li controlla.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/cRgVnPRzcWBgboot2CQOItQFx0D.jpg', 'Action, Sci-Fi, Thriller', NULL),
(152, 'Maze Runner: The Death Cure', 'movie', '2018', 1, 'Dylan O\'Brien, Kaya Scodelario, Thomas Brodie-Sangster', 'Thomas guida i suoi amici nell\'ultima missione per entrare nell\'ultima città rimasta e salvare i loro compagni.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/2EBZeVp4I1UnH6pT78INflzMrtI.jpg', 'Action, Sci-Fi, Thriller', NULL),
(153, 'The Hunger Games', 'movie', '2012', 1, 'Jennifer Lawrence, Josh Hutcherson, Liam Hemsworth', 'Katniss Everdeen si offre volontaria per prendere il posto di sua sorella in un torneo mortale trasmesso in TV.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/yXCbOiVDCxO71zI7cuwBRXdftq8.jpg', 'Action, Adventure, Sci-Fi', NULL),
(154, 'The Hunger Games: Catching Fire', 'movie', '2013', 1, 'Jennifer Lawrence, Josh Hutcherson, Liam Hemsworth', 'Dopo aver vinto i giochi, Katniss e Peeta diventano il bersaglio del presidente Snow, che organizza un edizione speciale con vecchi vincitori.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/vrQHDXjVmbYzadOXQ0UaObunoy2.jpg', 'Action, Adventure, Sci-Fi', NULL),
(155, 'The Hunger Games: Mockingjay - Part 1', 'movie', '2014', 1, 'Jennifer Lawrence, Josh Hutcherson, Liam Hemsworth', 'Katniss diventa il simbolo della ribellione contro Capitol City.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/4FAA18ZIja70d1Tu5hr5cj2q1sB.jpg', 'Action, Adventure, Sci-Fi', NULL),
(156, 'The Hunger Games: Mockingjay - Part 2', 'movie', '2015', 1, 'Jennifer Lawrence, Josh Hutcherson, Liam Hemsworth', 'Katniss guida la ribellione nella battaglia finale per rovesciare il presidente Snow.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/lImKHDfExAulp16grYm8zD5eONE.jpg', 'Action, Adventure, Sci-Fi', NULL),
(157, 'Divergent', 'movie', '2014', 1, 'Shailene Woodley, Theo James, Kate Winslet', 'In una società divisa in cinque fazioni, una ragazza scopre di essere Divergente e deve nascondere la sua identità per sopravvivere.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/aNh4Q3iuPKDMPi2SL7GgOpiLukX.jpg', 'Action, Adventure, Sci-Fi', NULL),
(158, 'Coraline', 'movie', '2009', 1, 'Dakota Fanning, Teri Hatcher, John Hodgman', 'Una bambina scopre una porta segreta che conduce a un mondo parallelo dove tutto sembra perfetto, ma nasconde terribili segreti.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/4jeFXQYytChdZYE9JYO7Un87IlW.jpg', 'Animation, Drama, Fantasy', NULL);
INSERT INTO `media` (`id`, `title`, `type`, `year_pub`, `total_seasons`, `cast`, `description`, `poster_url`, `genres`, `deleted_at`) VALUES
(159, 'Corpse Bride', 'movie', '2005', 1, 'Johnny Depp, Helena Bonham Carter, Emily Watson', 'Un giovane sposo si ritrova accidentalmente sposato con una sposa morta nel mondo dei defunti.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/isb2Qow76GpqYmsSyfdMfsYAjts.jpg', 'Animation, Drama, Fantasy', NULL),
(160, 'The Notebook', 'movie', '2004', 1, 'Ryan Gosling, Rachel McAdams, James Garner', 'Un uomo legge a una donna malata di Alzheimer la storia di un amore estivo che ha cambiato le loro vite.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/rNzQyW4f8B8cQeg7Dgj3n6eT5k9.jpg', 'Drama, Romance', NULL),
(161, 'The Devil Wears Prada', 'movie', '2006', 1, 'Meryl Streep, Anne Hathaway, Emily Blunt', 'Una giovane donna diventa assistente di una potente direttrice di una rivista di moda e scopre un mondo spietato.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/8912AsVuS7Sj915apArUFbv6F9L.jpg', 'Comedy, Drama', NULL),
(162, 'Mean Girls', 'movie', '2004', 1, 'Lindsay Lohan, Rachel McAdams, Tina Fey', 'Una ragazza che ha vissuto in Africa si trova a dover navigare tra le cliques di un liceo americano.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/fXm3YKXAEjx7d2tIWDg9TfRZtsU.jpg', 'Comedy', NULL),
(163, 'Titanic', 'movie', '1997', 1, 'Leonardo DiCaprio, Kate Winslet, Billy Zane', 'Due ragazzi di classi sociali diverse si innamorano a bordo del Titanic durante il suo fatale viaggio inaugurale.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg', 'Drama, Romance', NULL),
(164, 'Star Wars: Episode IV - A New Hope', 'movie', '1977', 1, 'Mark Hamill, Harrison Ford, Carrie Fisher', 'Un giovane contadino si unisce a un misterioso guerriero Jedi per salvare la principessa e distruggere la più potente arma dell\'Impero.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/6FfCtAuVAW8XJjZ7eWeLibRLWTw.jpg', 'Action, Adventure, Fantasy', NULL),
(165, 'Star Wars: Episode V - The Empire Strikes Back', 'movie', '1980', 1, 'Mark Hamill, Harrison Ford, Carrie Fisher', 'Darth Vader dà la caccia a Luke Skywalker mentre l\'Impero colpisce i ribelli.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/nNAeTmF4CtdSgMDplXTDPOpYzsX.jpg', 'Action, Adventure, Fantasy', NULL),
(166, 'Star Wars: Episode VI - Return of the Jedi', 'movie', '1983', 1, 'Mark Hamill, Harrison Ford, Carrie Fisher', 'Luke Skywalker combatte per salvare suo padre e sconfiggere l\'Impero una volta per tutte.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/wUn5w8Pu8roIfU8mqD0owaChGOt.jpg', 'Action, Adventure, Fantasy', NULL),
(167, 'Eyes Wide Shut', 'movie', '1999', 1, 'Tom Cruise, Nicole Kidman, Sydney Pollack', 'Un medico si imbatte in una misteriosa società segreta dopo che sua moglie gli confessa desideri inconfessabili.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/9gVdD6sOk10k9Cx2p0zeXzfJOWR.jpg', 'Drama, Mystery, Thriller', NULL),
(168, 'The Matrix Reloaded', 'movie', '2003', 1, 'Keanu Reeves, Laurence Fishburne, Carrie-Anne Moss', 'Neo e i ribelli continuano la loro lotta contro le macchine, scoprendo la vera natura della Matrix.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/aA5qHS0FbSXO8PxcxUIHbDrJyuh.jpg', 'Action, Sci-Fi', NULL),
(169, 'The Matrix Revolutions', 'movie', '2003', 1, 'Keanu Reeves, Laurence Fishburne, Carrie-Anne Moss', 'Neo si sacrifica per salvare l\'umanità nella battaglia finale contro le macchine.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/bkkS61w94ZVMNVd8KEyyJl2tnY5.jpg', 'Action, Sci-Fi', NULL),
(170, 'Kill Bill: Vol. 2', 'movie', '2004', 1, 'Uma Thurman, David Carradine, Michael Madsen', 'La Sposa continua la sua vendetta contro Bill e i suoi ex compagni, scoprendo il passato della sua nemesi.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/2yhg0mZQMhDyvUQ4rG1IZ4oIA8L.jpg', 'Action, Crime, Thriller', NULL),
(171, 'Memento', 'movie', '2000', 1, 'Guy Pearce, Carrie-Anne Moss, Joe Pantoliano', 'Un uomo con perdita di memoria a breve termine usa tatuaggi e appunti per trovare l\'assassino di sua moglie.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/fKTPH2WvH8nHTXeBYBVhawtRqtR.jpg', 'Mystery, Thriller', NULL),
(172, 'The Shining', 'movie', '1980', 1, 'Jack Nicholson, Shelley Duvall, Danny Lloyd', 'Uno scrittore diventa il custode di un hotel isolato per l\'inverno, scivolando nella follia insieme alla sua famiglia.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/uAR0AWqhQL1hQa69UDEbb2rE5Wx.jpg', 'Drama, Horror', NULL),
(173, 'Oldboy', 'movie', '2003', 1, 'Choi Min-sik, Yoo Ji-tae, Kang Hye-jung', 'Un uomo viene imprigionato in una cella per 15 anni senza sapere perché, poi viene rilasciato e cerca vendetta.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/aszprx9ZNNGD2J6ntQuvcFGsLza.jpg', 'Action, Drama, Mystery', NULL),
(174, 'Hannibal', 'show', '2013', 3, 'Mads Mikkelsen, Hugh Dancy, Caroline Dhavernas', 'La complessa relazione tra l\'investigatore Will Graham e il dottor Hannibal Lecter, uno psichiatra cannibale.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/imzvb941su6uhQ158GGurk7vF28.jpg', 'Crime, Drama, Horror', NULL),
(175, 'Fleabag', 'show', '2016', 2, 'Phoebe Waller-Bridge, Sian Clifford, Andrew Scott', 'Una giovane donna a Londra naviga tra lutti, relazioni e una vita sessuale complicata con ironia e dolore.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/27vEYsRKa3eAniwmoccOoluEXQ1.jpg', 'Comedy, Drama', NULL),
(176, 'Star Wars: Episode I - The Phantom Menace', 'movie', '1999', 1, 'Ewan McGregor, Liam Neeson, Natalie Portman', 'Due Jedi scoprono un ragazzo schiavo con un potenziale senza precedenti nella Forza, mentre la Federazione dei Commercianti minaccia il pianeta Naboo.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/6wkfovpn7Eq8dYNKaG5PY3q2oq6.jpg', 'Action, Adventure, Fantasy', NULL),
(177, 'Star Wars: Episode II - Attack of the Clones', 'movie', '2002', 1, 'Ewan McGregor, Hayden Christensen, Natalie Portman', 'Dieci anni dopo gli eventi del primo episodio, la Repubblica è minacciata da un movimento separatista, mentre Anakin Skywalker viene assegnato come guardia del corpo della senatrice Padmé Amidala.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/oZNPzxqM2s5DyVWab09NTQScDQt.jpg', 'Action, Adventure, Fantasy', NULL),
(178, 'Star Wars: Episode III - Revenge of the Sith', 'movie', '2005', 1, 'Ewan McGregor, Hayden Christensen, Natalie Portman', 'La guerra dei cloni infuria mentre i Separatisti rapiscono il cancelliere Palpatine. Anakin Skywalker si avvicina sempre di più al lato oscuro della Forza, con conseguenze tragiche per l\'intera galassia.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/xfSAoBEm9MNBjmlNcDYLvLSMlnq.jpg', 'Action, Adventure, Fantasy', NULL),
(179, 'Star Wars: Episode VII - The Force Awakens', 'movie', '2015', 1, 'Harrison Ford, Mark Hamill, Carrie Fisher', 'Trent\'anni dopo la sconfitta dell\'Impero, una nuova minaccia chiamata Primo Ordine emerge. Una giovane spazzina e un disertore dello stormtrooper cercano Luke Skywalker.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/wqnLdwVXoBjKibFRR5U3y0aDUhs.jpg', 'Action, Adventure, Fantasy', NULL),
(180, 'Star Wars: Episode VIII - The Last Jedi', 'movie', '2017', 1, 'Mark Hamill, Carrie Fisher, Adam Driver', 'Rey cerca l\'aiuto di Luke Skywalker per comprendere la Forza, mentre la Resistenza affronta il Primo Ordine in una fuga disperata.', 'https://image.tmdb.org/t/p/w500/kOVEVeg59E0wsnXmF9nrh6OmWII.jpg', 'Action, Adventure, Fantasy', NULL),
(181, 'Star Wars: Episode IX - The Rise of Skywalker', 'movie', '2019', 1, 'Carrie Fisher, Mark Hamill, Adam Driver', 'La battaglia finale tra la Resistenza e il Primo Ordine, mentre Rey affronta il suo destino e il ritorno dell\'imperatore Palpatine.', 'https://image.tmdb.org/t/p/w500/db32LaOibwEliAmSL2jjDF6oDdj.jpg', 'Action, Adventure, Fantasy', NULL),
(184, 'Shrek 2', 'movie', '2004', 1, 'Mike Myers, Eddie Murphy, Cameron Diaz', 'Shrek e Fiona tornano dalla luna di miele e vengono invitati dai genitori di lei nel lontano regno di Molto Molto Lontano. Qui scoprono che i genitori non sono felici di vedere la figlia sposata con un orco.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/2yYP0PQjG8zVqturh1BAqu2Tixl.jpg', 'Animation, Comedy, Adventure, Family', NULL),
(185, 'Shrek the Third', 'movie', '2007', 1, 'Mike Myers, Eddie Murphy, Cameron Diaz', 'Quando il re dei molto molto lontano muore, Shrek e i suoi amici devono trovare il legittimo erede al trono: Artie, un adolescente imbranato della scuola di corte.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/n4SexGGQzI26E269tfpa80MZaGV.jpg', 'Animation, Comedy, Adventure, Family', NULL),
(186, 'Shrek Forever After', 'movie', '2010', 1, 'Mike Myers, Eddie Murphy, Cameron Diaz', 'Shrek, stanco della vita familiare, firma un contratto con il folletto Rumpelstiltskin che lo porta in una realtà alternativa dove non è mai nato. Dovrà ritrovare i suoi amori e rompere l\'incantesimo.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/6HrfPZtKcGmX2tUWW3cnciZTaSD.jpg', 'Animation, Comedy, Adventure, Family', NULL),
(187, 'Puss in Boots', 'movie', '2011', 1, 'Antonio Banderas, Salma Hayek, Zach Galifianakis', 'Prima di incontrare Shrek, il leggendario gatto con gli stivali intraprende un\'avventura con Kitty Zampa di Velluto e Uomo Pasticcio per rubare le leggendarie uova d\'oro.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/n4UkIqNYSTr4DPoHCVfLrL8mbre.jpg', 'Animation, Comedy, Adventure, Family', NULL),
(188, 'Puss in Boots: The Last Wish', 'movie', '2022', 1, 'Antonio Banderas, Salma Hayek, Harvey Guillén', 'Dopo aver bruciato otto delle sue nove vite, il Gatto con gli Stivali intraprende un\'epica avventura per trovare l\'ultimo desiderio e ripristinare le sue vite.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/kuf6dutpsT0vSVehic3EZIqkOBt.jpg', 'Animation, Comedy, Adventure, Family', NULL),
(189, 'Insurgent', 'movie', '2015', 1, 'Shailene Woodley, Theo James, Kate Winslet', 'Tris e Four fuggono da Jeanine e cercano rifugio tra i ribelli. Devono trovare la scatola misteriosa che contiene i segreti del passato per sconfiggere il sistema.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/dP5Fb6YRfzmCQtRbHOr2kO7tJW9.jpg', 'Action, Adventure, Sci-Fi', NULL),
(190, 'Allegiant', 'movie', '2016', 1, 'Shailene Woodley, Theo James, Jeff Daniels', 'Tris e Four varcano le mura di Chicago per scoprire la verità sul loro mondo. Scoprono che tutto ciò che sanno è solo un esperimento più grande.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/faq9JlF8znUGQ5p3En1W61Fi5p0.jpg', 'Action, Adventure, Sci-Fi', NULL),
(191, 'Devilman Crybaby', 'anime', '2018', 1, 'Koki Uchiyama, Ayaka Fukuhara, Megumu Han', 'Akira Fudo, un ragazzo timido e gentile, si fonde con il demone Amon diventando Devilman. Dovrà combattere contro altri demoni mentre cerca di mantenere la sua umanità in un mondo che sprofonda nel caos e nell\'odio.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/2pQ9xfgDa3L3QpoXfkNhISby2R4.jpg', 'Animation, Action, Horror, Drama', NULL),
(192, 'Nana', 'anime', '2006', 1, 'Romai Paku, KAORI, Akira Ishida', 'Due ragazze entrambe di nome Nana diventano coinquiline a Tokyo. Una vuole diventare una cantante rock, l\'altra segue il suo amore. Le loro vite si intrecciano in una storia di amicizia, amore e musica.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/egEROVWFVUupRhK03Bj5IVGAEGu.jpg', 'Animation, Drama, Romance', NULL),
(193, 'Dororo', 'anime', '2019', 1, 'Hiroki Suzuki, Rio Suzuki, Naoya Uchida', 'Un samurai vende il corpo di suo figlio a 48 demoni in cambio del potere. Il bambino, Hyakkimaru, nasce senza pelle, occhi, orecchie e arti. Insieme al piccolo ladro Dororo, viaggia per uccidere i demoni e reclamare il suo corpo.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/2qSzgSE80OFrfgg5UFYbATdCQ6t.jpg', 'Animation, Action, Adventure, Fantasy', NULL),
(194, 'The Promised Neverland', 'anime', '2019', 2, 'Sumire Morohoshi, Mariya Ise, Shinei Ueki', 'In un orfanotrofio apparentemente perfetto, tre bambini scoprono la terribile verità: sono allevati come cibo per demoni. Iniziano così a pianificare una fuga disperata.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/oBgRCpAbtMpk1v8wfdsIph7lPQE.jpg', 'Animation, Mystery, Horror, Sci-Fi', NULL),
(195, 'Castlevania', 'anime', '2017', 4, 'Richard Armitage, James Callis, Alejandra Reynoso', 'Treasure Hunter Trevor Belmont, il mago Sypha e il figlio di Dracula, Alucard, si uniscono per fermare il signore dei vampiri che vuole sterminare l\'umanità.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/WzFHnJY44uDERER0xi1jOdoafT.jpg', 'Animation, Action, Adventure, Fantasy', NULL),
(196, 'Frieren: Beyond Journey\'s End', 'anime', '2023', 1, 'Kana Ichinose, Nobuhiko Okamoto, Atsumi Tanezaki', 'Dopo aver sconfitto il Re Demone, l\'elfa maga Frieren vive molto più a lungo dei suoi compagni umani. Decide di intraprendere un nuovo viaggio per capire meglio le emozioni umane e onorare la memoria degli amici scomparsi.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/dqZENchTd7lp5zht7BdlqM7RBhD.jpg', 'Animation, Drama, Fantasy', NULL),
(197, 'Kill la Kill', 'anime', '2013', 1, 'Ami Koshimizu, Ryoka Yuzuki, Toshihiko Seki', 'Ryuko Matoi cerca l\'assassino di suo padre con una spada a forma di lama gigante. Si scontra con Satsuki Kiryuin e il Consiglio Studentesco dell\'Accademia Honnouji, che controllano studenti con uniformi dotate di poteri.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/4F1WtP3dFIwLPOfa3u29VEVnNkf.jpg', 'Animation, Action, Comedy', NULL),
(198, 'Inuyasha', 'anime', '2000', 7, 'Kappei Yamaguchi, Satsuki Yukino, Kumiko Watanabe', 'Kagome, una ragazza moderna, viene trasportata nel Giappone feudale dove si risveglia Inuyasha, un mezzodemone. Insieme cercano i frammenti della Sfera dei Quattro Spiriti per sconfiggere il malvagio Naraku.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/mxiMX71ZUDYRYZYer4PVm8SnO7U.jpg', 'Animation, Action, Adventure, Fantasy', NULL),
(199, 'Darling in the Franxx', 'anime', '2018', 1, 'Yuto Uemura, Haruka Tomatsu, Yuichi Nakamura', 'In un futuro distopico, i bambini vivono in piantagioni e pilotano giganteschi robot chiamati Franxx per difendersi da misteriose creature. La storia si concentra su Hiro e Zero Two, un\'ibrida umano-dinosauro.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/m6R8gI3brohD6izeVCXFmuGeV2m.jpg', 'Animation, Action, Drama, Romance, Sci-Fi', NULL),
(200, 'Pluto', 'anime', '2023', 1, 'Shinshu Fuji, Yoko Hikasa, Minori Suzuki', 'In un mondo dove robot e umani coesistono, il robot detective Gesicht indaga su una serie di omicidi che coinvolgono i sette robot più potenti del mondo. Un thriller che esplora cosa significa essere umani.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/agf5sETjlO35s3EDA7wwGliZ5UW.jpg', 'Animation, Mystery, Drama, Sci-Fi', NULL),
(201, 'One Punch Man', 'anime', '2015', 2, 'Makoto Furukawa, Kaito Ishikawa, Yuichi Nakamura', 'Saitama è un eroe talmente potente che sconfigge qualsiasi nemico con un solo pugno. Annoiato dalla sua forza schiacciante, cerca un avversario degno di lui.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/3yvPziuLr2lT6DGP3M0jO7yjBVt.jpg', 'Animation, Action, Comedy', NULL),
(202, 'Hellsing Ultimate', 'anime', '2006', 1, 'Jouji Nakata, Fumiko Orikasa, Yoshiko Sakakibara', 'Alucard, il più potente vampiro della leggenda, lavora per l\'organizzazione Hellsing contro vampiri e creature soprannaturali che minacciano l\'Inghilterra.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/fum0tvBuVVeofFoHI0IXHgrzKEa.jpg', 'Animation, Action, Horror', NULL),
(203, 'Black Lagoon', 'anime', '2006', 1, 'Ami Koshimizu, Hiroaki Hirata, Megumi Toyoguchi', 'Rock, un impiegato giapponese rapito da un gruppo di mercenari illegali, decide di unirsi a loro. Insieme navigano nei mari del sud-est asiatico in missioni pericolose.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/sQlHhWScg6qmakL1ywtcjjVKKqV.jpg', 'Animation, Action, Crime', NULL),
(204, 'Ergo Proxy', 'anime', '2006', 1, 'Rie Kugimiya, Koji Yusa, Akiko Yajima', 'In un mondo post-apocalittico dove umani e androidi (AutoReiv) coesistono in cupole, una misteriosa epidemia infetta i robot. La detective Re-l Mayer indaga sul fenomeno scoprendo verità nascoste.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/iOLrx13WhB9vkS1DebI8fUBqI22.jpg', 'Animation, Mystery, Sci-Fi, Psychological', NULL),
(205, 'Elfen Lied', 'anime', '2004', 1, 'Sanae Kobayashi, Chihiro Suzuki, Mamiko Noto', 'Lucy, una giovane donna con poteri telecinetici letali, fugge da un laboratorio militare. Viene trovata senza memoria da due ragazzi che cercano di aiutarla, mentre il suo alter ego violento minaccia tutti.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/mYakikF9MYpiRRQKnXQD6ubRHwr.jpg', 'Animation, Action, Horror, Drama', NULL),
(206, 'Akame ga Kill!', 'anime', '2014', 1, 'Sora Amamiya, Soma Saito, Yukari Tamura', 'Tatsumi, un giovane guerriero, si unisce all\'esercito rivoluzionario Night Raid per combattere contro l\'Impero corrotto. Insieme useranno armi leggendarie chiamate Teigu.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/rMpvMbSlPbm5QYfFem9fx2Jnttq.jpg', 'Animation, Action, Adventure, Fantasy', NULL),
(207, 'Sailor Moon', 'anime', '1992', 5, 'Kotono Mitsuishi, Aya Hisakawa, Michie Tomizawa', 'Usagi Tsukino, una ragazza normale, scopre di essere la guerriera Sailor Moon, destinata a proteggere la Terra dal male. Insieme ad altre guerriere Sailor, combatte contro forze oscure.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/wz45BNOMLRZdxXm94P8NGevKubm.jpg', 'Animation, Action, Romance, Fantasy', NULL),
(208, 'Euphoria', 'show', '2019', 3, 'Zendaya, Hunter Schafer, Jacob Elordi, Alexa Demie, Sydney Sweeney, Maude Apatow, Barbie Ferreira, Angus Cloud, Storm Reid, Eric Dane', 'Un gruppo di studenti delle superiori naviga in un mondo di sesso, droghe, traumi, identità, amore e social media. La serie segue Rue Bennett, una tossicodipendente alle prese con la sobrietà, e i suoi compagni in una rappresentazione cruda e senza filtri dell\'adolescenza moderna.', 'https://www.themoviedb.org/t/p/w600_and_h900_face/aJrG7OkoTMPWG5c8opz8a93AZPY.jpg', 'Drama', NULL),
(210, '1', 'movie', '1999', 1, 'Boku no Pico, Peppe Fetish, Peppe Brescia, Rosario Muniz', 'io', '', 'Romance', '2026-05-04 13:23:51');

-- --------------------------------------------------------

--
-- Struttura della tabella `reviews`
--

CREATE TABLE `reviews` (
  `id` int NOT NULL,
  `id_user` int DEFAULT NULL,
  `id_media` int DEFAULT NULL,
  `rating` int DEFAULT NULL,
  `comment` varchar(2000) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ;

--
-- Dump dei dati per la tabella `reviews`
--

INSERT INTO `reviews` (`id`, `id_user`, `id_media`, `rating`, `comment`, `created_at`) VALUES
(30, 1, 4, 9, 'Inception è un viaggio mentale incredibile. La regia di Nolan è precisa come un orologio svizzero. La scena finale della trottola mi tormenta ancora dopo anni!', '2026-04-29 14:28:37'),
(31, 2, 4, 10, 'Uno dei miei film preferiti di sempre. La colonna sonora di Hans Zimmer aggiunge una tensione pazzesca a ogni scena del sogno.', '2026-04-29 14:28:37'),
(32, 4, 1, 10, 'La trasformazione di Walter White da uomo qualunque a mostro è scritta magistralmente. Non c è un singolo buco di trama in 5 stagioni.', '2026-04-29 14:28:37'),
(33, 5, 3, 10, 'L attacco dei giganti non è solo un anime, è un saggio politico e sociale. I colpi di scena della quarta stagione sono da fuori di testa.', '2026-04-29 14:28:37'),
(34, 6, 2, 9, 'Cinema puro. La fotografia e l interpretazione di Marlon Brando hanno definito un genere. Un po lungo, ma necessario.', '2026-04-29 14:28:37'),
(35, 7, 5, 8, 'Il duello psicologico tra Light e L è la cosa più avvincente che abbia mai visto. Peccato per la seconda metà della serie che cala un po.', '2026-04-29 14:28:37'),
(36, 1, 11, 10, 'Interstellar mi ha fatto piangere come un bambino. La rappresentazione del tempo e dell amore come forza fisica è geniale.', '2026-04-29 14:28:37'),
(37, 3, 21, 9, 'Nonostante il finale controverso, le prime stagioni di Game of Thrones rimangono l apice della televisione fantasy.', '2026-04-29 14:28:37'),
(38, 2, 33, 9, 'Fight Club è una critica feroce al consumismo. Brad Pitt è in stato di grazia e il plot twist finale è leggendario.', '2026-04-29 14:28:37'),
(39, 4, 36, 10, 'Parasite merita ogni premio vinto. Una regia impeccabile che passa dalla commedia nera al thriller in modo fluidissimo.', '2026-04-29 14:28:37'),
(40, 5, 41, 10, 'Steins;Gate parte lento ma quando ingrana diventa il miglior prodotto sui viaggi nel tempo mai creato. El Psy Kongroo!', '2026-04-29 14:28:37'),
(41, 6, 44, 7, 'Evangelion è difficile da digerire. Molto psicologico e astratto, forse troppo nel finale, ma visivamente è un opera d arte.', '2026-04-29 14:28:37'),
(42, 7, 29, 9, 'The Bear cattura l ansia di una cucina professionale in modo quasi insopportabile. Recitazione di altissimo livello.', '2026-04-29 14:28:37'),
(43, 4, 12, 10, 'Il Cavaliere Oscuro non è solo un film di supereroi, è un poliziesco teso e brutale. Heath Ledger ha regalato una performance che rimarrà nella storia del cinema. La tensione tra caos e ordine è palpabile in ogni scena.', '2026-04-29 14:29:53'),
(44, 5, 11, 9, 'Interstellar tocca corde emotive profonde. La colonna sonora di Hans Zimmer è un personaggio a sé stante. Anche se la parte scientifica è complessa, il cuore del film è il legame tra padre e figlia.', '2026-04-29 14:29:53'),
(45, 1, 14, 10, 'Schindler\'s List è un opera necessaria. La scelta del bianco e nero rende tutto più crudo e reale. È un film che ti svuota l anima ma che tutti dovrebbero vedere per non dimenticare.', '2026-04-29 14:29:53'),
(46, 6, 31, 9, 'Matrix ha ridefinito il genere sci-fi. Le coreografie dei combattimenti e l idea della realtà simulata erano avanti anni luce per il 1999. Ancora oggi visivamente impressionante.', '2026-04-29 14:29:53'),
(47, 2, 39, 10, 'Whiplash è un crescendo di adrenalina. Il rapporto tossico tra allievo e maestro è rappresentato con una ferocia incredibile. Il finale è uno dei montaggi più potenti degli ultimi vent anni.', '2026-04-29 14:29:53'),
(48, 7, 21, 8, 'Game of Thrones ha cambiato il modo di fare televisione. La qualità produttiva è cinematografica. Peccato per la fretta delle ultime stagioni, ma il viaggio è stato comunque epico.', '2026-04-29 14:29:53'),
(49, 3, 25, 9, 'True Detective (Stagione 1) è la perfezione del genere noir. L atmosfera densa della Louisiana e i dialoghi filosofici tra Rust e Marty sono scritti divinamente.', '2026-04-29 14:29:53'),
(50, 4, 8, 9, 'The Boys è la boccata d aria fresca di cui il genere supereroistico aveva bisogno. Dissacrante, violento e terribilmente cinico. Homelander è il villain più inquietante della TV attuale.', '2026-04-29 14:29:53'),
(51, 5, 24, 10, 'Chernobyl è una lezione di storia e di tensione. Riesce a trasmettere l orrore dell invisibile (le radiazioni) in modo magistrale. Una miniserie perfetta sotto ogni punto di vista.', '2026-04-29 14:29:53'),
(52, 6, 15, 10, 'Fullmetal Alchemist Brotherhood è l anime perfetto. Equilibrio totale tra azione, dramma, politica e commedia. La crescita dei fratelli Elric è un percorso di formazione indimenticabile.', '2026-04-29 14:29:53'),
(53, 7, 43, 9, 'Cowboy Bebop è stile puro. Un mix incredibile di sci-fi, noir e jazz. Ogni episodio ha un anima diversa e il finale è semplicemente perfetto. See you space cowboy...', '2026-04-29 14:29:53'),
(54, 1, 42, 9, 'Vinland Saga è una sorpresa continua. Inizia come una storia di vendetta vichinga ma si trasforma in una riflessione profonda sulla violenza e sul senso della vita.', '2026-04-29 14:29:53'),
(55, 2, 45, 8, 'Jujutsu Kaisen ha un comparto tecnico mostruoso. Le animazioni di MAPPA rendono ogni combattimento un opera d arte visiva. Storia classica ma eseguita con estrema cura.', '2026-04-29 14:29:53'),
(56, 2, 7, 1, 'schifo totale', '2026-04-29 15:08:05'),
(57, 1, 3, 10, 'La migliore storia mai creata sulla faccia della terra', '2026-05-01 09:56:08'),
(58, 1, 1, 8, 'Non lo ho mai visto ma scommetto che spacca', '2026-05-01 11:09:02'),
(59, 3, 31, 9, 'bello', '2026-05-01 13:09:31'),
(60, 1, 46, 9, 'Dune è visionaria, Villeneuve ha creato un universo epico. Scene del deserto ipnotiche.', '2026-05-01 13:39:12'),
(61, 2, 47, 10, 'Parte II supera l\'originale. De Niro giovane magistrale.', '2026-05-01 13:39:12'),
(62, 3, 48, 8, 'Arcane eleva League a capolavoro animato. Fluida.', '2026-05-01 13:39:12'),
(63, 4, 49, 10, 'LOTR ridefinisce fantasy epico. Ogni frame un dipinto.', '2026-05-01 13:39:12'),
(64, 5, 50, 9, 'Succession è Shakespeare aziendale. Dialoghi taglienti.', '2026-05-01 13:39:12'),
(65, 6, 51, 10, 'Your Name mi ha fatto piangere. Shinkai maestro emozioni.', '2026-05-01 13:39:12'),
(66, 7, 52, 9, 'Fury Road puro action. Charlize icona.', '2026-05-01 13:39:12'),
(67, 8, 53, 8, 'Mandalorian divertente, Baby Yoda ruba scena.', '2026-05-01 13:39:12'),
(68, 1, 54, 10, 'Spirited Away poesia animata. Miyazaki genio.', '2026-05-01 13:39:12'),
(69, 2, 55, 9, 'The Crown cattura solitudine potere. Cast perfetto.', '2026-05-01 13:39:12'),
(70, 1, 56, 9, 'Vikings epica vichinga pura. Ragnar icona assoluta.', '2026-05-01 13:56:34'),
(71, 2, 57, 10, 'Erased capolavoro time travel. Trama perfetta.', '2026-05-01 13:56:34'),
(72, 3, 58, 9, 'Violet Evergarden mi ha distrutto emotivamente. Animazione sublime.', '2026-05-01 13:56:34'),
(73, 4, 59, 10, 'A Silent Voice lezione bullismo magistrale.', '2026-05-01 13:56:34'),
(74, 5, 60, 10, 'Better Call Saul uguale a BB ma diverso. Genio.', '2026-05-01 13:56:34'),
(75, 6, 61, 8, 'Last Kingdom stile Vikings ma storica.', '2026-05-01 13:56:34'),
(77, 8, 63, 9, 'Fate/Zero action dark fantasy top.', '2026-05-01 13:56:34'),
(78, 1, 64, 9, 'Clannad After Story lacrima certa. Emozioni pure.', '2026-05-01 13:56:34'),
(79, 2, 65, 10, 'One Punch Man divertente e action mozzafiato.', '2026-05-01 13:56:34'),
(80, 3, 66, 9, 'Madoka Magica sovverte genere magical girl.', '2026-05-01 13:56:34'),
(81, 4, 67, 8, 'Toradora! tsundere queen Taiga adorabile.', '2026-05-01 13:56:34'),
(82, 5, 68, 9, 'Noragami underrated gem. Yato carismatico.', '2026-05-01 13:56:34'),
(83, 6, 69, 8, 'Black Butler estetica vittoriana dark.', '2026-05-01 13:56:34'),
(84, 7, 70, 10, 'Fruits Basket reboot perfetto. Cuore.', '2026-05-01 13:56:34'),
(85, 8, 56, 9, 'Vikings battaglie epiche, trama solida.', '2026-05-01 13:56:34'),
(86, 1, 57, 10, 'Erased finale twist geniale.', '2026-05-01 13:56:34'),
(87, 2, 58, 9, 'Violet lettere toccano anima.', '2026-05-01 13:56:34'),
(88, 3, 59, 10, 'Silent Voice redenzione vera.', '2026-05-01 13:56:34'),
(89, 4, 60, 10, 'Saul Goodman prequel perfetto.', '2026-05-01 13:56:34'),
(90, 1, 36, 10, 'mamma mia quanto spacca', '2026-05-02 09:56:54'),
(91, 1, 71, 9, 'Shrek è un capolavoro dell\'animazione. Divertente, profondo e con una colonna sonora incredibile!', '2026-05-02 10:24:08'),
(92, 2, 71, 10, 'Non invecchia mai. Lo rivedo sempre volentieri!', '2026-05-02 10:24:08'),
(93, 3, 72, 8, 'Visivamente stupendo, un film che fa riflettere. Ryan Gosling è fantastico.', '2026-05-02 10:24:08'),
(94, 4, 72, 9, 'Greta Gerwig ha creato qualcosa di unico. Divertente e commovente.', '2026-05-02 10:24:08'),
(95, 1, 73, 10, 'Un film intenso e potente. Cillian Murphy è perfetto nel ruolo.', '2026-05-02 10:24:08'),
(96, 2, 73, 9, 'Tre ore che volano. Nolan al suo meglio.', '2026-05-02 10:24:08'),
(97, 3, 74, 9, 'Coreografie mozzafiato. L\'azione è portata a un altro livello.', '2026-05-02 10:24:08'),
(98, 4, 74, 10, 'Donnie Yen vs Keanu Reeves è da urlo. Miglior action del 2023.', '2026-05-02 10:24:08'),
(99, 5, 75, 10, 'Non ho mai visto niente di simile. Un viaggio pazzesco e pieno di cuore.', '2026-05-02 10:24:08'),
(100, 6, 75, 10, 'Michelle Yeoh merita ogni premio. Geniale e commovente.', '2026-05-02 10:24:08'),
(101, 7, 76, 9, 'Superiore all\'originale. Le scene di volo sono spettacolari.', '2026-05-02 10:24:08'),
(102, 8, 76, 9, 'Tom Cruise è leggenda. Emozionante e adrenalinico.', '2026-05-02 10:24:08'),
(103, 1, 77, 9, 'Un Batman cupo e noir. Pattinson sorprende tutti.', '2026-05-02 10:24:08'),
(104, 2, 77, 8, 'Un po\' lungo ma atmosfera perfetta.', '2026-05-02 10:24:08'),
(105, 3, 78, 10, 'Un kolossal epico. Soprannota l\'originale in tutto.', '2026-05-02 10:24:08'),
(106, 4, 78, 10, 'Villeneuve è un genio. Visivamente sbalorditivo.', '2026-05-02 10:24:08'),
(107, 5, 79, 10, 'Animazione rivoluzionaria. Una delle migliori cose viste al cinema.', '2026-05-02 10:24:08'),
(108, 6, 79, 10, 'Il multiverso come non lo avete mai visto. Capolavoro.', '2026-05-02 10:24:08'),
(109, 7, 80, 9, 'Brendan Fraser commuove fino alle lacrime. Un film tostissimo.', '2026-05-02 10:24:08'),
(110, 8, 80, 8, 'Bello ma pesante. Per stomaci forti.', '2026-05-02 10:24:08'),
(111, 1, 81, 8, 'Visivamente stupendo ma storia un po\' scontata.', '2026-05-02 10:24:08'),
(112, 2, 81, 7, 'Meglio del primo per l\'acqua ma troppo lungo.', '2026-05-02 10:24:08'),
(113, 3, 82, 8, 'Divertente e intelligente. Daniel Craig è perfetto.', '2026-05-02 10:24:08'),
(114, 4, 82, 7, 'Non bello come il primo ma comunque godibile.', '2026-05-02 10:24:08'),
(115, 5, 83, 9, 'Un giallo moderno fantastico. Cast stellare.', '2026-05-02 10:24:08'),
(116, 6, 84, 9, 'Sorkin scrive dialoghi da urlo. Eisenberg perfetto.', '2026-05-02 10:24:08'),
(117, 7, 85, 10, 'Wes Anderson al suo meglio. Stile unico e indimenticabile.', '2026-05-02 10:24:08'),
(118, 8, 85, 9, 'Una carezza all\'anima. Fotografia incredibile.', '2026-05-02 10:24:08'),
(119, 1, 86, 9, 'Un musical che ti entra nel cuore. Il finale è devastante.', '2026-05-02 10:24:08'),
(120, 2, 86, 10, 'Emma Stone e Ryan Gosling sono magici. Colonna sonora indimenticabile.', '2026-05-02 10:24:08'),
(121, 3, 87, 10, 'Joaquin Phoenix è semplicemente mostruoso. Un film disturbante e necessario.', '2026-05-02 10:24:08'),
(122, 4, 87, 9, 'Un capolavoro oscuro. La trasformazione di Arthur è incredibile.', '2026-05-02 10:24:08'),
(123, 5, 88, 8, 'DiCaprio soffre davvero. Duro ma bellissimo.', '2026-05-02 10:24:08'),
(124, 6, 88, 9, 'Fotografia mozzafiato. L\'orso è una scena da antologia.', '2026-05-02 10:24:08'),
(125, 7, 89, 10, 'Tarantino al massimo. Christoph Waltz perfetto.', '2026-05-02 10:24:08'),
(126, 8, 89, 9, 'Divertente,暴力e intelligente. Capolavoro.', '2026-05-02 10:24:08'),
(127, 1, 90, 9, 'La scena iniziale è da Oscar. Waltz domina la scena.', '2026-05-02 10:24:08'),
(128, 2, 90, 10, 'Uno dei migliori film di Tarantino.', '2026-05-02 10:24:08'),
(129, 3, 91, 8, 'Azione pura e stile. La colonna sonora è leggendaria.', '2026-05-02 10:24:08'),
(130, 4, 91, 9, 'Uma Thurman è iconica. Violento e bellissimo.', '2026-05-02 10:24:08'),
(131, 5, 92, 8, 'Un esordio clamoroso. Dialoghi indimenticabili.', '2026-05-02 10:24:08'),
(132, 6, 92, 9, 'La scena del rasoio... brividi.', '2026-05-02 10:24:08'),
(133, 7, 93, 7, 'Troppo lungo ma gran finale. Fotografia bellissima.', '2026-05-02 10:24:08'),
(134, 8, 93, 8, 'Un western claustrofobico. Ottimo cast.', '2026-05-02 10:24:08'),
(135, 1, 95, 10, 'Chainsaw Man è follia pura. MAPPA ha fatto un lavoro incredibile.', '2026-05-02 10:24:08'),
(136, 2, 95, 9, 'Azioni, sangue e personaggi assurdi. Fantastico.', '2026-05-02 10:24:08'),
(137, 3, 96, 10, 'Anya è la cosa più adorabile mai creata. Perfetto per tutti.', '2026-05-02 10:24:08'),
(138, 4, 96, 9, 'Una famiglia fittizia che scalda il cuore. Divertentissimo.', '2026-05-02 10:24:08'),
(139, 5, 97, 8, 'Shonen classico ma ben fatto. All Might è leggenda.', '2026-05-02 10:24:08'),
(140, 6, 97, 7, 'Un po\' lungo ma buono.', '2026-05-02 10:24:08'),
(141, 7, 98, 8, 'Coinvolgente e drammatico. Il protagonista piange tantissimo ma funziona.', '2026-05-02 10:24:08'),
(142, 8, 98, 9, 'Time travel fatto bene. Emozionante.', '2026-05-02 10:24:08'),
(143, 1, 99, 8, 'Stupendo visivamente, trama solida.', '2026-05-02 10:24:08'),
(144, 2, 99, 9, 'Uno dei migliori isekai. Animazione di qualità.', '2026-05-02 10:24:08'),
(145, 3, 100, 9, 'Subaru soffre tantissimo. Una storia cruda e bella.', '2026-05-02 10:24:08'),
(146, 4, 100, 10, 'Rem è la migliore ragazza. Capolavoro.', '2026-05-02 10:24:08'),
(147, 5, 101, 7, 'Bello ma frustrante. Raphtalia salva tutto.', '2026-05-02 10:24:08'),
(148, 6, 101, 8, 'Dopo la prima stagione cala un po\'.', '2026-05-02 10:24:08'),
(149, 7, 102, 8, 'Ainz è un antieroe fantastico. Divertente e violento.', '2026-05-02 10:24:08'),
(150, 8, 102, 9, 'Overlord è un isekai diverso. Molto figo.', '2026-05-02 10:24:08'),
(151, 1, 103, 9, 'Rimuru è adorabile. Un isekai leggero e divertente.', '2026-05-02 10:24:08'),
(152, 2, 103, 9, 'La costruzione del mondo è fantastica.', '2026-05-02 10:24:08'),
(153, 3, 104, 8, 'Cringe e divertente nello stesso tempo. Molto originale.', '2026-05-02 10:24:08'),
(154, 4, 105, 10, 'Pedro Pascal è incredibile. La puntata 3 è un capolavoro.', '2026-05-02 10:24:08'),
(155, 5, 105, 10, 'Migliore trasposizione di un videogioco. Emozionante.', '2026-05-02 10:24:08'),
(156, 6, 106, 9, 'Jenna Ortega è perfetta. L\'estetica è bellissima.', '2026-05-02 10:24:08'),
(157, 7, 106, 8, 'Divertente e dark. La scena del ballo è iconica.', '2026-05-02 10:24:08'),
(158, 8, 107, 8, 'Evan Peters impressionante. Molto disturbante.', '2026-05-02 10:24:08'),
(159, 1, 107, 9, 'Ben fatto ma tosto. Non per tutti.', '2026-05-02 10:24:08'),
(160, 2, 108, 10, 'Anya Taylor-Joy è fantastica. Scacchi non sono mai stati così emozionanti.', '2026-05-02 10:24:08'),
(161, 3, 108, 10, 'Una serie perfetta. Visivamente stupenda.', '2026-05-02 10:24:08'),
(162, 4, 109, 7, 'Henry Cavill è perfetto ma la serie è altalenante.', '2026-05-02 10:24:08'),
(163, 5, 109, 8, 'Divertente ma poteva essere meglio.', '2026-05-02 10:24:08'),
(164, 6, 110, 9, 'Il finale della prima stagione è sconvolgente. Aspettavo tanto questa serie.', '2026-05-02 10:24:08'),
(165, 7, 110, 10, 'Invincible è incredibile. VOmetti ovunque ma bellissimo.', '2026-05-02 10:24:08'),
(166, 8, 111, 9, 'Un adattamento fedele e bellissimo. Dream perfetto.', '2026-05-02 10:24:08'),
(167, 1, 111, 8, 'Lenta ma atmosferica. Ottima produzione.', '2026-05-02 10:24:08'),
(168, 2, 112, 10, 'Andor è il meglio di Star Wars da anni. Serie seria e matura.', '2026-05-02 10:24:08'),
(169, 3, 112, 9, 'Dialoghi fantastici. Un capolavoro.', '2026-05-02 10:24:08'),
(170, 4, 113, 8, 'La season 7 è spettacolare. Per fan di Star Wars.', '2026-05-02 10:24:08'),
(171, 5, 113, 9, 'L\'unica cosa buona dei prequel.', '2026-05-02 10:24:08'),
(172, 6, 114, 8, 'Tom Hiddleston è nato per questo ruolo. Divertente.', '2026-05-02 10:24:08'),
(173, 7, 114, 9, 'La seconda stagione migliora tutto.', '2026-05-02 10:24:08'),
(174, 8, 115, 9, 'Un esperimento riuscito. Finale bellissimo.', '2026-05-02 10:24:08'),
(175, 1, 115, 10, 'WandaVision è arte.', '2026-05-02 10:24:08'),
(176, 2, 116, 7, 'Buona ma non indimenticabile.', '2026-05-02 10:24:08'),
(177, 3, 116, 8, 'Kim Kardashian? No, John Walker è fantastico.', '2026-05-02 10:24:08'),
(178, 4, 117, 8, 'Natale con Clint. Divertente e leggera.', '2026-05-02 10:24:08'),
(179, 5, 117, 7, 'Buona, niente di piu\'.', '2026-05-02 10:24:08'),
(180, 6, 118, 9, 'Oscar Isaac da solo vale la serie. Dark e psicologico.', '2026-05-02 10:24:08'),
(181, 7, 118, 8, 'Bella ma poteva osare di piu\'.', '2026-05-02 10:24:08'),
(182, 8, 119, 6, 'Divertente ma troppo leggera per i gusti miei.', '2026-05-02 10:24:08'),
(183, 1, 119, 7, 'Simpatica ma dimenticabile.', '2026-05-02 10:24:08'),
(184, 2, 120, 7, 'Carina ma per un pubblico giovane.', '2026-05-02 10:24:08'),
(192, 2, 105, 1, 'schifo totale', '2026-05-02 13:16:19'),
(193, 1, 146, 9, 'Questo film è fantastico!', '2026-05-02 14:44:08'),
(194, 1, 59, 10, 'mai pianto così tanto', '2026-05-02 14:45:15'),
(195, 1, 132, 9, 'per ora è wow', '2026-05-02 16:34:42'),
(196, 17, 110, 7, 'niente male, ma spero ci sia di più nelle prossime stagioni', '2026-05-04 11:51:55');

-- --------------------------------------------------------

--
-- Struttura della tabella `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `surname` varchar(50) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `role` enum('user','admin') NOT NULL DEFAULT 'user',
  `avatar` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dump dei dati per la tabella `users`
--

INSERT INTO `users` (`id`, `name`, `surname`, `email`, `password`, `created_at`, `role`, `avatar`) VALUES
(1, 'kat', 'ouzif', 'kat@gmail.com', '$2y$10$IJ8q8vDz0HHJeHKftuvUae5o3J3JR1k.U27C39Y7HRkLBK2asodKG', '2026-04-29 08:39:26', 'admin', 'aliencat2.jpg'),
(2, 'marco', 'mechelli', 'marco@gmail.com', '$2y$10$/gx9exdZBhemmxVyyy341.jfaqkt6LosFS/BcwG6KGZcU3ytYfvgK', '2026-04-29 08:41:11', 'user', 'download.jpg'),
(3, 'rebs', 'appetito', 'rebs@gmail.com', '$2y$10$qUpcIkw5FVbgGIwR4pTVie2DKXPe9h5lswQHFHIuy44rVwAkS8iQa', '2026-04-29 08:41:35', 'user', 'rigbycat.jpg'),
(4, 'martina', 'veschi', 'marti@gmail.com', '$2y$10$jrDgEa.Z5rr7cuE3aEyhT.sIKB.UcvQxiLV6ruaxEoCxWynMePOgu', '2026-04-29 14:02:12', 'user', 'HiddenFeelings.jpg'),
(5, 'damiano', 'demattei', 'dami@gmail.com', '$2y$10$hCmHMwb8BwbFvgwjNJI1meDXfWvbwpel3QbCQC1rwftHjOtVrp3DK', '2026-04-29 14:02:32', 'user', 'angry.jpg'),
(6, 'gio', 'milazzo', 'gio@gmail.com', '$2y$10$9sbZGxMwUs4Cw4prcWJ/jegq7g3DsyezAmM9ZeiFmWbbcEaQTZkeu', '2026-04-29 14:02:55', 'user', 'mrkitty.jpg'),
(7, 'giovanni', 'giardina', 'giovanni@gmail.com', '$2y$10$cgHkRY0L21mQuNApKqVF5uXmCk5u3AO/BI.X.iFZ7R5NIv5GMJuGO', '2026-04-29 14:03:47', 'user', 'angry.jpg'),
(8, 'ali', 'taher', 'ali@gmail.com', '$2y$10$lwLWf7Qbq0ck.G3ts1O0fO24n.bVGzx4RR4NNtFG5Fp0wSFixpcpu', '2026-05-01 13:33:40', 'user', 'chaos.jpg'),
(17, 'Matteo', 'Salvini', 'mattoSalvo@gmail.com', '$2y$10$lQnKVgnlEXIANvb1wjzvEuVdgFw3O3YPCktfNLW9cEGW7HkpRX19e', '2026-05-04 11:47:02', 'user', 'angry.jpg');

-- --------------------------------------------------------

--
-- Struttura della tabella `user_library`
--

CREATE TABLE `user_library` (
  `id_user` int NOT NULL,
  `id_media` int NOT NULL,
  `status` enum('watching','completed','plan_to_watch','dropped') DEFAULT 'plan_to_watch',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dump dei dati per la tabella `user_library`
--

INSERT INTO `user_library` (`id_user`, `id_media`, `status`, `updated_at`) VALUES
(1, 1, 'completed', '2026-04-29 08:43:44'),
(1, 3, 'watching', '2026-04-29 08:43:44'),
(1, 5, 'plan_to_watch', '2026-04-29 08:43:44'),
(1, 7, 'completed', '2026-04-29 11:29:17'),
(1, 10, 'completed', '2026-04-29 11:29:17'),
(1, 11, 'completed', '2026-04-29 11:29:17'),
(1, 14, 'completed', '2026-04-29 14:29:53'),
(1, 15, 'completed', '2026-04-29 11:29:17'),
(1, 18, 'completed', '2026-04-29 11:29:17'),
(1, 22, 'plan_to_watch', '2026-04-29 11:29:17'),
(1, 25, 'watching', '2026-04-29 11:29:17'),
(1, 26, 'completed', '2026-04-29 11:29:17'),
(1, 31, 'completed', '2026-05-01 09:49:22'),
(1, 36, 'completed', '2026-05-02 09:57:00'),
(1, 42, 'completed', '2026-04-29 14:29:53'),
(1, 44, 'completed', '2026-05-02 14:30:08'),
(1, 46, 'watching', '2026-05-01 13:39:23'),
(1, 48, 'plan_to_watch', '2026-05-01 13:39:23'),
(1, 56, 'watching', '2026-05-01 13:56:59'),
(1, 57, 'completed', '2026-05-01 13:56:59'),
(1, 58, 'plan_to_watch', '2026-05-01 13:56:59'),
(1, 59, 'completed', '2026-05-02 15:12:14'),
(1, 70, 'watching', '2026-05-01 13:56:59'),
(1, 132, 'watching', '2026-05-02 16:34:34'),
(1, 146, 'completed', '2026-05-02 14:44:08'),
(2, 1, 'completed', '2026-05-01 09:07:53'),
(2, 2, 'completed', '2026-04-29 08:43:44'),
(2, 4, 'plan_to_watch', '2026-04-29 08:43:44'),
(2, 7, 'completed', '2026-04-29 11:29:17'),
(2, 8, 'completed', '2026-04-29 11:29:17'),
(2, 9, 'completed', '2026-04-29 11:29:17'),
(2, 16, 'completed', '2026-04-29 11:29:17'),
(2, 17, 'completed', '2026-04-29 11:29:17'),
(2, 19, 'completed', '2026-04-29 11:29:17'),
(2, 23, 'plan_to_watch', '2026-04-29 11:29:17'),
(2, 29, 'completed', '2026-04-29 11:29:17'),
(2, 31, 'watching', '2026-05-01 09:21:57'),
(2, 39, 'completed', '2026-04-29 14:29:53'),
(2, 40, 'plan_to_watch', '2026-05-01 09:29:17'),
(2, 45, 'completed', '2026-04-29 14:29:53'),
(2, 47, 'completed', '2026-05-01 13:39:23'),
(2, 50, 'watching', '2026-05-01 13:39:23'),
(2, 58, 'completed', '2026-05-01 14:06:16'),
(2, 59, 'completed', '2026-05-01 13:56:59'),
(2, 60, 'watching', '2026-05-01 13:56:59'),
(2, 61, 'plan_to_watch', '2026-05-01 13:56:59'),
(2, 66, 'completed', '2026-05-01 13:56:59'),
(2, 105, 'watching', '2026-05-02 13:16:23'),
(3, 3, 'plan_to_watch', '2026-04-29 08:43:44'),
(3, 5, 'watching', '2026-04-29 08:43:44'),
(3, 6, 'dropped', '2026-04-29 08:43:44'),
(3, 8, 'watching', '2026-04-29 11:29:17'),
(3, 11, 'completed', '2026-04-29 11:29:17'),
(3, 13, 'plan_to_watch', '2026-04-29 11:29:17'),
(3, 20, 'completed', '2026-04-29 11:29:17'),
(3, 21, 'completed', '2026-04-29 11:29:17'),
(3, 24, 'completed', '2026-04-29 11:29:17'),
(3, 25, 'completed', '2026-04-29 14:29:53'),
(3, 30, 'completed', '2026-04-29 11:29:17'),
(3, 31, 'completed', '2026-05-01 13:09:22'),
(3, 51, 'completed', '2026-05-01 13:39:23'),
(3, 63, 'watching', '2026-05-01 13:56:59'),
(3, 64, 'completed', '2026-05-01 13:56:59'),
(4, 1, 'completed', '2026-04-29 14:18:02'),
(4, 8, 'completed', '2026-04-29 14:29:53'),
(4, 12, 'completed', '2026-04-29 14:29:53'),
(4, 31, 'plan_to_watch', '2026-04-29 14:18:02'),
(4, 36, 'completed', '2026-04-29 14:18:02'),
(4, 49, 'completed', '2026-05-01 13:39:23'),
(4, 52, 'plan_to_watch', '2026-05-01 13:39:23'),
(4, 65, 'plan_to_watch', '2026-05-01 13:56:59'),
(4, 66, 'dropped', '2026-05-01 13:56:59'),
(4, 67, 'completed', '2026-05-01 13:56:59'),
(5, 3, 'completed', '2026-04-29 14:18:02'),
(5, 11, 'completed', '2026-04-29 14:29:53'),
(5, 15, 'completed', '2026-04-29 14:18:02'),
(5, 24, 'completed', '2026-04-29 14:29:53'),
(5, 40, 'watching', '2026-04-29 14:18:02'),
(5, 41, 'completed', '2026-04-29 14:18:02'),
(5, 53, 'watching', '2026-05-01 13:39:23'),
(5, 68, 'watching', '2026-05-01 13:56:59'),
(5, 69, 'completed', '2026-05-01 13:56:59'),
(5, 70, 'plan_to_watch', '2026-05-01 13:56:59'),
(6, 2, 'completed', '2026-04-29 14:18:02'),
(6, 15, 'completed', '2026-04-29 14:29:53'),
(6, 25, 'dropped', '2026-04-29 14:18:02'),
(6, 31, 'completed', '2026-04-29 14:29:53'),
(6, 32, 'completed', '2026-04-29 14:18:02'),
(6, 44, 'completed', '2026-04-29 14:18:02'),
(6, 54, 'completed', '2026-05-01 13:39:23'),
(6, 56, 'completed', '2026-05-01 13:56:59'),
(6, 65, 'completed', '2026-05-01 13:56:59'),
(7, 5, 'completed', '2026-04-29 14:18:02'),
(7, 13, 'plan_to_watch', '2026-04-29 14:18:02'),
(7, 21, 'completed', '2026-04-29 14:29:53'),
(7, 29, 'completed', '2026-04-29 14:18:02'),
(7, 39, 'completed', '2026-04-29 14:18:02'),
(7, 43, 'completed', '2026-04-29 14:29:53'),
(7, 55, 'plan_to_watch', '2026-05-01 13:39:23'),
(7, 57, 'plan_to_watch', '2026-05-01 13:56:59'),
(7, 58, 'completed', '2026-05-01 13:56:59'),
(7, 61, 'dropped', '2026-05-01 13:56:59'),
(8, 46, 'plan_to_watch', '2026-05-01 13:39:23'),
(8, 51, 'dropped', '2026-05-01 13:39:23'),
(8, 59, 'watching', '2026-05-01 13:56:59'),
(8, 60, 'completed', '2026-05-01 13:56:59'),
(8, 64, 'plan_to_watch', '2026-05-01 13:56:59'),
(17, 110, 'completed', '2026-05-04 11:51:32');

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `media`
--
ALTER TABLE `media`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_deleted_at` (`deleted_at`);

--
-- Indici per le tabelle `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_user` (`id_user`),
  ADD KEY `id_media` (`id_media`);

--
-- Indici per le tabelle `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indici per le tabelle `user_library`
--
ALTER TABLE `user_library`
  ADD PRIMARY KEY (`id_user`,`id_media`),
  ADD KEY `id_media` (`id_media`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `media`
--
ALTER TABLE `media`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=211;

--
-- AUTO_INCREMENT per la tabella `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`id_media`) REFERENCES `media` (`id`) ON DELETE CASCADE;

--
-- Limiti per la tabella `user_library`
--
ALTER TABLE `user_library`
  ADD CONSTRAINT `user_library_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_library_ibfk_2` FOREIGN KEY (`id_media`) REFERENCES `media` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
