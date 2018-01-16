
postgresql:
  pkg.installed:
    - name: postgresql
  service.running:
    - enable: True
    - require:
      - pkg: postgresql

postgresql-client:
  pkg.installed:
    - name: postgresql-client

postgres:
  postgres_user.present:
    - name: postgres
    - password: postgres
    - createdb: True
    - createuser: False
    - superuser: True
    - runas: postgres
    - require:
      - service: postgresql
