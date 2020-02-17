# Color palette
$CONSOLE_PALETTE = [ordered]@{
    "30m" = [System.ConsoleColor]::Black
    "31m" = [System.ConsoleColor]::DarkBlue
    "32m" = [System.ConsoleColor]::DarkGreen
    "33m" = [System.ConsoleColor]::DarkCyan
    "34m" = [System.ConsoleColor]::DarkRed
    "35m" = [System.ConsoleColor]::DarkMagenta
    "36m" = [System.ConsoleColor]::DarkYellow
    "37m" = [System.ConsoleColor]::Gray
    "1;30m" = [System.ConsoleColor]::DarkGray
    "1;31m" = [System.ConsoleColor]::Blue
    "1;32m" = [System.ConsoleColor]::Green
    "1;33m" = [System.ConsoleColor]::Cyan
    "1;34m" = [System.ConsoleColor]::Red
    "1;35m" = [System.ConsoleColor]::Magenta
    "1;36m" = [System.ConsoleColor]::Yellow
    "1;37m" = [System.ConsoleColor]::White
    "40m" = [System.ConsoleColor]::Black
    "41m" = [System.ConsoleColor]::DarkBlue
    "42m" = [System.ConsoleColor]::DarkGreen
    "43m" = [System.ConsoleColor]::DarkCyan
    "44m" = [System.ConsoleColor]::DarkRed
    "45m" = [System.ConsoleColor]::DarkMagenta
    "46m" = [System.ConsoleColor]::DarkYellow
    "47m" = [System.ConsoleColor]::Gray
}

# Escape sequence
$ESC = [char]0x1b

Export-ModuleMember -Variable *