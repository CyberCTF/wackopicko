# WackoPicko

[WackoPicko](https://github.com/adamdoupe/WackoPicko) by Adam Doupe: a photo-sharing website
with known vulnerabilities, first used in the paper
[Why Johnny Can't Pentest](https://adamdoupe.com/publications/black-box-scanners-dimva2010.pdf)
to evaluate black-box web vulnerability scanners. This repository runs it with
[Isoloom](https://www.isoloom.com): [`isoloom.yml`](isoloom.yml) describes the machine, and the
upstream source in [`build/web/app/`](build/web/app) builds with its own Dockerfile on a rebuilt
copy of its `tutum/lamp` base, which Docker can no longer pull.

| Machine | Service |
| --- | --- |
| web | WackoPicko (Apache, PHP 5) on port 80, with its MySQL database in the same container |

WackoPicko connects to MySQL on `localhost` with PHP 5's `mysql_connect`, so the database stays
in the web container, as in upstream's image.

## Run it

```bash
isoloom generate
isoloom run docker
```

Then open http://localhost:8080/ and log in as `scanner1` / `scanner1`. The same spec runs as
Docker on a local VM (`docker-vm`), on a cloud VM (`cloud-docker`) or on Kubernetes. Lab guide:
[WackoPicko on aldeid](https://www.aldeid.com/wiki/WackoPicko) and the paper above.

Upstream version and commit: [UPSTREAM.md](UPSTREAM.md).

## Licence

MIT, as WackoPicko ([LICENSE](LICENSE)). This application is deliberately vulnerable: keep it
isolated.
