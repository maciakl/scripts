$JOURNAL_DIR = $HOME + "\Dropbox\Apps\Markdown Journal"

# Make sure journal folder exists
if( test-path $JOURNAL_DIR )
{
    # Check if ag is installed
    if( get-command -EA SilentlyContinue ag )
    {
        & ag -i $ARGS "$JOURNAL_DIR\*.markdown"
    }
    else
    {
        $JOURNAL_SEARCH = ""
    }
}
else
{
    write-warning "Journal folder: $JOURNAL_DIR does not exist"
}
