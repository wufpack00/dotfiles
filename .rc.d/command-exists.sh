# Check if a program exists in shell
function command_exists() {
    command -v $1 >/dev/null 2>&1
}
