# We want to start claude independent of any other program to avoid spawning
# multiple VSCode windows on startup - So remove these possibly-inherited env vars
'VSCODE_PID', 'VSCODE_CWD', 'TERM_PROGRAM' | ForEach-Object { if (Test-Path "Env:$_") { Remove-Item "Env:$_" } }

# Ensure $args[0] is set to something
if ($args[0]) { Set-Location $args[0] }
claude
