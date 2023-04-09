# PassportParking

# Grep Current Directory for Phrase Excluding Compiled Directories
function f {
    grep -r "$1" * --exclude=*.min.{css,js,map} --exclude-dir=build --exclude-dir=\.git --exclude-dir=\.idea --exclude-dir=\.settings --exclude-dir=\.metadata --exclude-dir=WEB-INF --exclude-dir=bin --exclude-dir=vendor --exclude=R.java --exclude=*.cache.html --exclude-dir=AFNetworking --exclude-dir=GoogleMaps.framework --exclude-dir=RSBarcodes_Swift --exclude-dir=XCGLogger --exclude-dir=google-maps-ios-utils --exclude-dir=zipzap 2>/dev/null
}

# Grep Current Directory for Phrase
function ff {
    grep -r "$1" * 2>/dev/null
}

# Grep Git Log History for Phrase
function flog {
    glp | grep "$1"
}

# Grep Git Log History for Phrase And Retrieve Commit Hash & Author
function fblame {
    git log -p | \grep "commit \|Author: \|$1" | \grep -B2 "$1"
}

# Run PHP Linter On All Files In Current Directory Showing Only Parse Errors
function checkphp {
    find . -type f -name \*.php -exec php -l {} \; | \grep "Errors parsing"
}

# Run PHP Linter On All Files In Current Directory Showing Results For Every File
function checkphpall {
    find . -type f -name \*.php -exec php -l {} \;
}
