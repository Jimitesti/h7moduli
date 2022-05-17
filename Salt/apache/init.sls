apache2:
  pkg.installed
a2enmod:
  cmd.run:
    - name: "a2enmod userdir"
    - creates: "/etc/apache2/mods-enabled/userdir.conf"
