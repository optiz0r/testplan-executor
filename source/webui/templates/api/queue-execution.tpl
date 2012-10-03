"success": {$success|json_encode}
{if ! $success}
    ,
    "page_replacements": {
        "dialog-header-title": {
            "content": "An error has occurred"
        },
        
        "dialog-body": {
            "content": {$failureMessage|json_encode}
        }
    },

    "dialog": {
        "show": true,
        "buttons": {
            "type": "ok",
            "actions": {
                "ok": [
                    "close-dialog"
                ]
            }
        }
    }
{/if}