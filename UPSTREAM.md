# Upstream

| | |
| --- | --- |
| Project | WackoPicko |
| Repository | https://github.com/adamdoupe/WackoPicko |
| Version | master (no release tags) |
| Commit | cabc1b3a06beda7df98e839fa2d84db9a4bdfee7 |
| Licence | MIT |

`build/web/app/` is that commit, unchanged, without its Git history. Upstream's Dockerfile
builds `FROM tutum/lamp`, an image Docker can no longer pull (schema 1 manifest). So
`build/web/Dockerfile` first rebuilds that base the way tutum/lamp did (Ubuntu 14.04, Apache,
PHP 5, MySQL 5.5 under supervisord, its scripts in `build/web/lamp/`), then runs upstream's
Dockerfile steps unchanged. To update, replace `build/web/app/` with a newer commit, then change
this table.
