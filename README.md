# monitoring-certyfikatow
Narzędzie monitorujące ważność certyfikatów - zdalnych i lokalnych z systemem powiadomień (bash,python)

Wykorzystane narzędzia:
Język skryptowy - BASH,
Python,
tablica crontab.

  Uruchomienie narzędzia:
1. Pierwszym krokiem jest wpisanie ścieżki folderu z lokalnymi certyfikatami oraz adresów IP ze zdalnymi certyfikatami w skrypcie: narzędzie_1.sh.

2. Następnie należy edytować program mail.py w celu podania ścieżki skryptu(narzędzie_1.sh), który będzie uruchamiany z pomocą wywołania subprocess.

  Mechanizm działania:
Program mail.py za pomocą wywołania systemowego subprocess uruchamia skrypt narzedzie_1.sh, który łączy się za pomocą komendy openssl z serwerem na port 443(w przypadku certyfikatu zdalnego) i uzyskuje dostęp do poglądu certyfikatu. Następnie wyłuskuje potrzebne mu informacje, np. czy certyfikat jest ważny. Po wygenerowaniu raportu, program automatycznie wysyła wiadomość e-mail z załączonym raportem w postaci .txt do administratora. Jeśli certyfikat traci ważność za mniej niż 30 dni, lub już wygasł, raport nas o tym ostrzega. W tablicy crontab należy umieścić odpowiedni wpis, w celu automatycznego uruchamiania narzędzia.

W celu zmiany konta e-mail, należy edytować program mail.py.
