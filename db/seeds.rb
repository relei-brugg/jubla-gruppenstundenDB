User.create ({name: "Ivo",
              email: "ivo@releibrugg.ch",
              password: "123456",
              password_confirmation: "123456",
              admin: true,
              moderator: true})

ActivityCategory.create ([ {name: 'ruhig'},
                           {name: 'aktiv'},
                           {name: 'kreativ'} ])

LocationCategory.create ([ {name: 'Drinnen'},
                           {name: 'Draussen'},
                           {name: 'im Wald'} ])

MethodCategory.create ([ {name: 'Basteln/Werken'},
                         {name: 'Technik/Wissen'},
                         {name: 'Action'},
                         {name: 'Sport/Bewegung'},
                         {name: 'Kochen/Backen'},
                         {name: 'Grössere Projekte'},
                         {name: 'Geländespiel'},
                         {name: 'Postenlauf'},
                         {name: 'Geschichten/Musik/Theater'} ])

SeasonCategory.create ([ {name: 'Frühling'},
                         {name: 'Sommer'},
                         {name: 'Herbst'},
                         {name: 'Winter'} ])