#!/bin/bash

opcje() {
  case $1 in
    1) head -n 5 "$2" ;;
    2) grep -v 'linux' "$2" ;;
    3) rev "$2" ;;
    4) ls -lt | head -10 ;;
    5) cat "$2" | tr '[:lower:]' '[:upper:]' ;;
    *) echo "Nieprawidłowa opcja z linii polecen." ;;
  esac
}

# Funkcje dla opcji z menu
opcja_1() {
  grep -E '^\s*(\S+\s+){4}\S+\s*$' "$1"
}

opcja_2() {
  rev "$1"
}

opcja_3() {
  ls | grep -E '([aeiouAEIOU].*){3,}'
}

opcja_4() {
  wc -w "$1"
}

opcja_5() {
  du -ch | grep 'total$'
}

# Wyświetlanie menu
pokazuj_menu() {
  echo "Wyświetl opcje:"
  echo "1) Wyświetl linie z 5 słowami"
  echo "2) Odwróc kolejność znaków w pliku"
  echo "3) Wyświetl pliki z 3 samogłoskami"
  echo "4) Zlicz słowa w pliku"
  echo "5) Podsumuj rozmiary plików"
  echo "6) Wyjście"
}

# Obsługa menu
menu() {
  local wybor
  read -p "Podaj numer opcji: " wybor
  case $wybor in
    1) opcja_1 "$1" ;;
    2) opcja_2 "$1" ;;
    3) opcja_3 ;;
    4) opcja_4 "$1" ;;
    5) opcja_5 ;;
    6) exit 0 ;;
    *) echo "Zły wybór. Spróbuj jeszcze." ;;
  esac
}

if [[ $# -gt 0 ]]; then
  opcje "$@"
else
  while true; do
    pokazuj_menu
    read -p "Podaj nazwę pliku: " file
    menu "$file"
  done
fi
