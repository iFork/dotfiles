# Backup and Restore Tilix configuration
Tilix stores it's configuration in dconf and you should be able to use the dconf tool to migrate settings. To dump the setting:

```bash
dconf dump /com/gexperts/Tilix/ > tilix.dconf
```

To load this file back into dconf on a different machine:

```bash
dconf load /com/gexperts/Tilix/ < tilix.dconf
```
