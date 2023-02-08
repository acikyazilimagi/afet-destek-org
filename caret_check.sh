if grep -q "\^" "pubspec.yaml"; then
    echo 'Caret (^) is not allowed in pubspec.yaml';
    exit 1
fi