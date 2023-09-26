vim.g.projectionist_heuristics = {
  artisan = {
    ['*'] = {
      start = 'php artisan serve',
      console = 'php artisan tinker',
    },
    ['app/*.php'] = {
      type = 'source',
      alternate = {
        'tests/{}Test.php',
      },
    },
    ['tests/*Test.php'] = {
      type = 'test',
      alternate = 'app/{}.php',
    },
    ['app/Models/*.php'] = {
      type = 'model',
    },
    ['app/Http/Controllers/*.php'] = {
      type = 'controller',
    },
    ['routes/*.php'] = {
      type = 'route',
    },
    ['database/migrations/*.php'] = {
      type = 'migration',
    },
  },
}
