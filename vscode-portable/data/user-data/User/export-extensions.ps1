..\..\..\bin\code.cmd --list-extensions | %{"code --install-extension $_"} > import-extensions.ps1
