module Poem exposing (..)


type alias Word =
    { text : String
    , x : Int
    , y : Int
    , width : Int
    , height : Int
    }


words : List Word
words =
    [ { text = "ONE"
      , x = 41
      , y = 69
      , height = 28
      , width = 49
      }
    , { text = "TOSS"
      , x = 96
      , y = 69
      , height = 28
      , width = 58
      }
    , { text = "OF"
      , x = 160
      , y = 69
      , height = 28
      , width = 31
      }
    , { text = "THE"
      , x = 197
      , y = 69
      , height = 28
      , width = 46
      }
    , { text = "DICE"
      , x = 249
      , y = 69
      , height = 28
      , width = 56
      }
    , { text = "NEVER"
      , x = 412
      , y = 113
      , height = 28
      , width = 80
      }
    , { text = "NOT"
      , x = 350
      , y = 157
      , height = 15
      , width = 26
      }
    , { text = "EVEN"
      , x = 380
      , y = 157
      , height = 15
      , width = 34
      }
    , { text = "WHEN"
      , x = 417
      , y = 157
      , height = 15
      , width = 39
      }
    , { text = "CAST"
      , x = 460
      , y = 157
      , height = 15
      , width = 33
      }
    , { text = "IN"
      , x = 496
      , y = 157
      , height = 15
      , width = 14
      }
    , { text = "ETERNAL"
      , x = 513
      , y = 157
      , height = 15
      , width = 59
      }
    , { text = "CIRCUMSTANCES"
      , x = 319
      , y = 172
      , height = 15
      , width = 108
      }
    , { text = "FROM"
      , x = 345
      , y = 203
      , height = 15
      , width = 37
      }
    , { text = "THE"
      , x = 385
      , y = 203
      , height = 15
      , width = 25
      }
    , { text = "DEPTHS"
      , x = 413
      , y = 203
      , height = 15
      , width = 50
      }
    , { text = "OF"
      , x = 466
      , y = 203
      , height = 15
      , width = 16
      }
    , { text = "A"
      , x = 485
      , y = 203
      , height = 15
      , width = 9
      }
    , { text = "SHIPWRECK"
      , x = 497
      , y = 203
      , height = 15
      , width = 75
      }
    , { text = "WHETHER"
      , x = 1
      , y = 268
      , height = 18
      , width = 78
      }
    , { text = "the"
      , x = 51
      , y = 286
      , height = 15
      , width = 16
      }
    , { text = "Abyss"
      , x = 81
      , y = 351
      , height = 15
      , width = 33
      }
    , { text = "whitened"
      , x = 1
      , y = 416
      , height = 15
      , width = 48
      }
    , { text = "becalmed"
      , x = 41
      , y = 447
      , height = 15
      , width = 50
      }
    , { text = "furious"
      , x = 81
      , y = 478
      , height = 15
      , width = 37
      }
    , { text = "under"
      , x = 121
      , y = 509
      , height = 15
      , width = 30
      }
    , { text = "an"
      , x = 154
      , y = 509
      , height = 15
      , width = 12
      }
    , { text = "inclination"
      , x = 169
      , y = 509
      , height = 15
      , width = 56
      }
    , { text = "glides"
      , x = 131
      , y = 524
      , height = 15
      , width = 31
      }
    , { text = "desperately"
      , x = 165
      , y = 524
      , height = 15
      , width = 59
      }
    , { text = "with"
      , x = 161
      , y = 589
      , height = 15
      , width = 23
      }
    , { text = "wing"
      , x = 187
      , y = 589
      , height = 15
      , width = 26
      }
    , { text = "its"
      , x = 144
      , y = 620
      , height = 15
      , width = 12
      }
    , { text = "own"
      , x = 160
      , y = 620
      , height = 15
      , width = 22
      }
    , { text = "in"
      , x = 248
      , y = 635
      , height = 15
      , width = 11
      }
    , { text = "advance"
      , x = 262
      , y = 635
      , height = 15
      , width = 42
      }
    , { text = "refallen"
      , x = 308
      , y = 635
      , height = 15
      , width = 39
      }
    , { text = "with"
      , x = 351
      , y = 635
      , height = 15
      , width = 23
      }
    , { text = "a"
      , x = 377
      , y = 635
      , height = 15
      , width = 6
      }
    , { text = "difficulty"
      , x = 386
      , y = 635
      , height = 15
      , width = 48
      }
    , { text = "in"
      , x = 437
      , y = 635
      , height = 15
      , width = 10
      }
    , { text = "setting"
      , x = 450
      , y = 635
      , height = 15
      , width = 35
      }
    , { text = "up"
      , x = 488
      , y = 635
      , height = 15
      , width = 13
      }
    , { text = "flight"
      , x = 505
      , y = 635
      , height = 15
      , width = 27
      }
    , { text = "and"
      , x = 380
      , y = 650
      , height = 15
      , width = 19
      }
    , { text = "covering"
      , x = 402
      , y = 650
      , height = 15
      , width = 45
      }
    , { text = "the"
      , x = 451
      , y = 650
      , height = 15
      , width = 16
      }
    , { text = "outpourings"
      , x = 470
      , y = 650
      , height = 15
      , width = 62
      }
    , { text = "cutting"
      , x = 410
      , y = 665
      , height = 15
      , width = 36
      }
    , { text = "utterly"
      , x = 449
      , y = 665
      , height = 15
      , width = 34
      }
    , { text = "the"
      , x = 486
      , y = 665
      , height = 15
      , width = 16
      }
    , { text = "leaps"
      , x = 505
      , y = 665
      , height = 15
      , width = 27
      }
    , { text = "very"
      , x = 331
      , y = 696
      , height = 15
      , width = 24
      }
    , { text = "interiorly"
      , x = 358
      , y = 696
      , height = 15
      , width = 48
      }
    , { text = "resumes"
      , x = 409
      , y = 696
      , height = 15
      , width = 43
      }
    , { text = "the"
      , x = 308
      , y = 727
      , height = 15
      , width = 16
      }
    , { text = "shade"
      , x = 327
      , y = 727
      , height = 15
      , width = 30
      }
    , { text = "buried"
      , x = 360
      , y = 727
      , height = 15
      , width = 33
      }
    , { text = "in"
      , x = 397
      , y = 727
      , height = 15
      , width = 10
      }
    , { text = "the"
      , x = 410
      , y = 727
      , height = 15
      , width = 16
      }
    , { text = "deep"
      , x = 429
      , y = 727
      , height = 15
      , width = 25
      }
    , { text = "by"
      , x = 457
      , y = 727
      , height = 15
      , width = 13
      }
    , { text = "that"
      , x = 473
      , y = 727
      , height = 15
      , width = 20
      }
    , { text = "alternative"
      , x = 496
      , y = 727
      , height = 15
      , width = 55
      }
    , { text = "sail"
      , x = 554
      , y = 727
      , height = 15
      , width = 18
      }
    , { text = "as"
      , x = 457
      , y = 758
      , height = 15
      , width = 11
      }
    , { text = "to"
      , x = 471
      , y = 758
      , height = 15
      , width = 10
      }
    , { text = "adapt"
      , x = 484
      , y = 758
      , height = 15
      , width = 29
      }
    , { text = "to"
      , x = 453
      , y = 773
      , height = 15
      , width = 10
      }
    , { text = "its"
      , x = 467
      , y = 773
      , height = 15
      , width = 12
      }
    , { text = "wingspan"
      , x = 482
      , y = 773
      , height = 15
      , width = 50
      }
    , { text = "its"
      , x = 352
      , y = 804
      , height = 15
      , width = 13
      }
    , { text = "gaping"
      , x = 368
      , y = 804
      , height = 15
      , width = 35
      }
    , { text = "depth"
      , x = 406
      , y = 804
      , height = 15
      , width = 29
      }
    , { text = "as"
      , x = 439
      , y = 804
      , height = 15
      , width = 10
      }
    , { text = "the"
      , x = 453
      , y = 804
      , height = 15
      , width = 16
      }
    , { text = "hull"
      , x = 472
      , y = 804
      , height = 15
      , width = 20
      }
    , { text = "of"
      , x = 437
      , y = 835
      , height = 15
      , width = 11
      }
    , { text = "a"
      , x = 451
      , y = 835
      , height = 15
      , width = 6
      }
    , { text = "vessel"
      , x = 460
      , y = 835
      , height = 15
      , width = 32
      }
    , { text = "tilted"
      , x = 382
      , y = 866
      , height = 15
      , width = 27
      }
    , { text = "to"
      , x = 412
      , y = 866
      , height = 15
      , width = 11
      }
    , { text = "one"
      , x = 426
      , y = 866
      , height = 15
      , width = 19
      }
    , { text = "or"
      , x = 448
      , y = 866
      , height = 15
      , width = 11
      }
    , { text = "the"
      , x = 462
      , y = 866
      , height = 15
      , width = 16
      }
    , { text = "other"
      , x = 481
      , y = 866
      , height = 15
      , width = 27
      }
    , { text = "side"
      , x = 511
      , y = 866
      , height = 15
      , width = 21
      }
    , { text = "THE"
      , x = 91
      , y = 897
      , height = 18
      , width = 31
      }
    , { text = "MASTER"
      , x = 126
      , y = 897
      , height = 18
      , width = 65
      }
    , { text = "outside"
      , x = 341
      , y = 899
      , height = 15
      , width = 38
      }
    , { text = "old"
      , x = 382
      , y = 899
      , height = 15
      , width = 16
      }
    , { text = "calculations"
      , x = 402
      , y = 899
      , height = 15
      , width = 62
      }
    , { text = "where"
      , x = 291
      , y = 915
      , height = 15
      , width = 32
      }
    , { text = "the"
      , x = 326
      , y = 915
      , height = 15
      , width = 16
      }
    , { text = "maneuver"
      , x = 345
      , y = 915
      , height = 15
      , width = 51
      }
    , { text = "with"
      , x = 400
      , y = 915
      , height = 15
      , width = 23
      }
    , { text = "age"
      , x = 426
      , y = 915
      , height = 15
      , width = 18
      }
    , { text = "forgotten"
      , x = 447
      , y = 915
      , height = 15
      , width = 48
      }
    , { text = "arisen"
      , x = 41
      , y = 946
      , height = 15
      , width = 31
      }
    , { text = "inferring"
      , x = 51
      , y = 961
      , height = 15
      , width = 45
      }
    , { text = "long"
      , x = 346
      , y = 961
      , height = 15
      , width = 23
      }
    , { text = "ago"
      , x = 373
      , y = 961
      , height = 15
      , width = 18
      }
    , { text = "he"
      , x = 395
      , y = 961
      , height = 15
      , width = 12
      }
    , { text = "grasped"
      , x = 410
      , y = 961
      , height = 15
      , width = 41
      }
    , { text = "the"
      , x = 454
      , y = 961
      , height = 15
      , width = 16
      }
    , { text = "helm"
      , x = 473
      , y = 961
      , height = 15
      , width = 26
      }
    , { text = "of"
      , x = 121
      , y = 992
      , height = 15
      , width = 11
      }
    , { text = "that"
      , x = 135
      , y = 992
      , height = 15
      , width = 20
      }
    , { text = "conflagration"
      , x = 158
      , y = 992
      , height = 15
      , width = 68
      }
    , { text = "at"
      , x = 230
      , y = 992
      , height = 15
      , width = 9
      }
    , { text = "his"
      , x = 242
      , y = 992
      , height = 15
      , width = 16
      }
    , { text = "feet"
      , x = 261
      , y = 992
      , height = 15
      , width = 19
      }
    , { text = "of"
      , x = 271
      , y = 1007
      , height = 15
      , width = 11
      }
    , { text = "the"
      , x = 285
      , y = 1007
      , height = 15
      , width = 16
      }
    , { text = "unanimous"
      , x = 304
      , y = 1007
      , height = 15
      , width = 57
      }
    , { text = "horizon"
      , x = 365
      , y = 1007
      , height = 15
      , width = 39
      }
    , { text = "there"
      , x = 231
      , y = 1038
      , height = 15
      , width = 26
      }
    , { text = "is"
      , x = 260
      , y = 1038
      , height = 15
      , width = 9
      }
    , { text = "preparing"
      , x = 272
      , y = 1038
      , height = 15
      , width = 50
      }
    , { text = "stirring"
      , x = 281
      , y = 1053
      , height = 15
      , width = 38
      }
    , { text = "and"
      , x = 322
      , y = 1053
      , height = 15
      , width = 19
      }
    , { text = "mixing"
      , x = 344
      , y = 1053
      , height = 15
      , width = 37
      }
    , { text = "in"
      , x = 306
      , y = 1068
      , height = 15
      , width = 10
      }
    , { text = "the"
      , x = 319
      , y = 1068
      , height = 15
      , width = 16
      }
    , { text = "fist"
      , x = 339
      , y = 1068
      , height = 15
      , width = 15
      }
    , { text = "that"
      , x = 358
      , y = 1068
      , height = 15
      , width = 19
      }
    , { text = "might"
      , x = 380
      , y = 1068
      , height = 15
      , width = 31
      }
    , { text = "clutch"
      , x = 414
      , y = 1068
      , height = 15
      , width = 32
      }
    , { text = "it"
      , x = 449
      , y = 1068
      , height = 15
      , width = 7
      }
    , { text = "as"
      , x = 156
      , y = 1083
      , height = 15
      , width = 11
      }
    , { text = "one"
      , x = 170
      , y = 1083
      , height = 15
      , width = 19
      }
    , { text = "menaces"
      , x = 192
      , y = 1083
      , height = 15
      , width = 45
      }
    , { text = "a"
      , x = 240
      , y = 1083
      , height = 15
      , width = 6
      }
    , { text = "destiny"
      , x = 249
      , y = 1083
      , height = 15
      , width = 38
      }
    , { text = "and"
      , x = 290
      , y = 1083
      , height = 15
      , width = 19
      }
    , { text = "the"
      , x = 312
      , y = 1083
      , height = 15
      , width = 16
      }
    , { text = "winds"
      , x = 331
      , y = 1083
      , height = 15
      , width = 31
      }
    , { text = "the"
      , x = 51
      , y = 1114
      , height = 15
      , width = 16
      }
    , { text = "unique"
      , x = 70
      , y = 1114
      , height = 15
      , width = 35
      }
    , { text = "Number"
      , x = 109
      , y = 1114
      , height = 15
      , width = 42
      }
    , { text = "which"
      , x = 154
      , y = 1114
      , height = 15
      , width = 32
      }
    , { text = "cannot"
      , x = 189
      , y = 1114
      , height = 15
      , width = 35
      }
    , { text = "be"
      , x = 227
      , y = 1114
      , height = 15
      , width = 13
      }
    , { text = "another"
      , x = 243
      , y = 1114
      , height = 15
      , width = 39
      }
    , { text = "Spirit"
      , x = 322
      , y = 1145
      , height = 15
      , width = 29
      }
    , { text = "to"
      , x = 364
      , y = 1160
      , height = 15
      , width = 10
      }
    , { text = "hurl"
      , x = 377
      , y = 1160
      , height = 15
      , width = 21
      }
    , { text = "it"
      , x = 402
      , y = 1160
      , height = 15
      , width = 7
      }
    , { text = "in"
      , x = 413
      , y = 1175
      , height = 15
      , width = 10
      }
    , { text = "the"
      , x = 426
      , y = 1175
      , height = 15
      , width = 16
      }
    , { text = "tempest"
      , x = 445
      , y = 1175
      , height = 15
      , width = 40
      }
    , { text = "refolding"
      , x = 319
      , y = 1190
      , height = 15
      , width = 48
      }
    , { text = "the"
      , x = 370
      , y = 1190
      , height = 15
      , width = 16
      }
    , { text = "division"
      , x = 389
      , y = 1190
      , height = 15
      , width = 42
      }
    , { text = "and"
      , x = 434
      , y = 1190
      , height = 15
      , width = 19
      }
    , { text = "passing"
      , x = 456
      , y = 1190
      , height = 15
      , width = 39
      }
    , { text = "proud"
      , x = 499
      , y = 1190
      , height = 15
      , width = 30
      }
    , { text = "hesitates"
      , x = 202
      , y = 1205
      , height = 15
      , width = 44
      }
    , { text = "a"
      , x = 150
      , y = 1220
      , height = 15
      , width = 6
      }
    , { text = "corpse"
      , x = 159
      , y = 1220
      , height = 15
      , width = 34
      }
    , { text = "by"
      , x = 196
      , y = 1220
      , height = 15
      , width = 13
      }
    , { text = "the"
      , x = 212
      , y = 1220
      , height = 15
      , width = 16
      }
    , { text = "arm"
      , x = 231
      , y = 1220
      , height = 15
      , width = 21
      }
    , { text = "set"
      , x = 255
      , y = 1220
      , height = 15
      , width = 14
      }
    , { text = "apart"
      , x = 273
      , y = 1220
      , height = 15
      , width = 26
      }
    , { text = "from"
      , x = 302
      , y = 1220
      , height = 15
      , width = 25
      }
    , { text = "the"
      , x = 330
      , y = 1220
      , height = 15
      , width = 16
      }
    , { text = "secret"
      , x = 350
      , y = 1220
      , height = 15
      , width = 30
      }
    , { text = "it"
      , x = 383
      , y = 1220
      , height = 15
      , width = 7
      }
    , { text = "keeps"
      , x = 394
      , y = 1220
      , height = 15
      , width = 29
      }
    , { text = "rather"
      , x = 9
      , y = 1235
      , height = 15
      , width = 30
      }
    , { text = "than"
      , x = 43
      , y = 1250
      , height = 15
      , width = 23
      }
    , { text = "to"
      , x = 69
      , y = 1250
      , height = 15
      , width = 10
      }
    , { text = "play"
      , x = 82
      , y = 1250
      , height = 15
      , width = 23
      }
    , { text = "like"
      , x = 73
      , y = 1265
      , height = 15
      , width = 19
      }
    , { text = "a"
      , x = 96
      , y = 1265
      , height = 15
      , width = 5
      }
    , { text = "hoary"
      , x = 105
      , y = 1265
      , height = 15
      , width = 29
      }
    , { text = "maniac"
      , x = 138
      , y = 1265
      , height = 15
      , width = 37
      }
    , { text = "the"
      , x = 131
      , y = 1280
      , height = 15
      , width = 16
      }
    , { text = "game"
      , x = 150
      , y = 1280
      , height = 15
      , width = 29
      }
    , { text = "in"
      , x = 81
      , y = 1295
      , height = 15
      , width = 10
      }
    , { text = "the"
      , x = 95
      , y = 1295
      , height = 15
      , width = 16
      }
    , { text = "name"
      , x = 114
      , y = 1295
      , height = 15
      , width = 28
      }
    , { text = "of"
      , x = 145
      , y = 1295
      , height = 15
      , width = 11
      }
    , { text = "waves"
      , x = 159
      , y = 1295
      , height = 15
      , width = 33
      }
    , { text = "one"
      , x = 244
      , y = 1310
      , height = 15
      , width = 19
      }
    , { text = "invades"
      , x = 266
      , y = 1310
      , height = 15
      , width = 40
      }
    , { text = "the"
      , x = 309
      , y = 1310
      , height = 15
      , width = 16
      }
    , { text = "chief"
      , x = 328
      , y = 1310
      , height = 15
      , width = 26
      }
    , { text = "flows"
      , x = 272
      , y = 1325
      , height = 15
      , width = 29
      }
    , { text = "like"
      , x = 304
      , y = 1325
      , height = 15
      , width = 19
      }
    , { text = "a"
      , x = 327
      , y = 1325
      , height = 15
      , width = 5
      }
    , { text = "submissive"
      , x = 336
      , y = 1325
      , height = 15
      , width = 57
      }
    , { text = "beard"
      , x = 397
      , y = 1325
      , height = 15
      , width = 29
      }
    , { text = "shipwreck"
      , x = 192
      , y = 1356
      , height = 15
      , width = 54
      }
    , { text = "that"
      , x = 249
      , y = 1356
      , height = 15
      , width = 20
      }
    , { text = "direct"
      , x = 272
      , y = 1356
      , height = 15
      , width = 29
      }
    , { text = "from"
      , x = 305
      , y = 1356
      , height = 15
      , width = 25
      }
    , { text = "man"
      , x = 333
      , y = 1356
      , height = 15
      , width = 23
      }
    , { text = "sans"
      , x = 310
      , y = 1387
      , height = 15
      , width = 22
      }
    , { text = "ship"
      , x = 335
      , y = 1387
      , height = 15
      , width = 22
      }
    , { text = "no"
      , x = 333
      , y = 1402
      , height = 15
      , width = 13
      }
    , { text = "matter"
      , x = 349
      , y = 1402
      , height = 15
      , width = 33
      }
    , { text = "where"
      , x = 410
      , y = 1433
      , height = 15
      , width = 31
      }
    , { text = "vain"
      , x = 445
      , y = 1433
      , height = 15
      , width = 22
      }
    , { text = "ancestrally"
      , x = 1
      , y = 1464
      , height = 15
      , width = 56
      }
    , { text = "to"
      , x = 61
      , y = 1464
      , height = 15
      , width = 10
      }
    , { text = "not"
      , x = 74
      , y = 1464
      , height = 15
      , width = 17
      }
    , { text = "open"
      , x = 94
      , y = 1464
      , height = 15
      , width = 25
      }
    , { text = "the"
      , x = 122
      , y = 1464
      , height = 15
      , width = 16
      }
    , { text = "hand"
      , x = 141
      , y = 1464
      , height = 15
      , width = 26
      }
    , { text = "clenched"
      , x = 126
      , y = 1479
      , height = 15
      , width = 46
      }
    , { text = "beyond"
      , x = 101
      , y = 1494
      , height = 15
      , width = 38
      }
    , { text = "the"
      , x = 143
      , y = 1494
      , height = 15
      , width = 15
      }
    , { text = "useless"
      , x = 162
      , y = 1494
      , height = 15
      , width = 37
      }
    , { text = "head"
      , x = 202
      , y = 1494
      , height = 15
      , width = 24
      }
    , { text = "legacy"
      , x = 41
      , y = 1525
      , height = 15
      , width = 34
      }
    , { text = "in"
      , x = 78
      , y = 1525
      , height = 15
      , width = 10
      }
    , { text = "the"
      , x = 92
      , y = 1525
      , height = 15
      , width = 15
      }
    , { text = "disappearance"
      , x = 111
      , y = 1525
      , height = 15
      , width = 73
      }
    , { text = "to"
      , x = 121
      , y = 1556
      , height = 15
      , width = 10
      }
    , { text = "someone"
      , x = 134
      , y = 1556
      , height = 15
      , width = 47
      }
    , { text = "ambiguous"
      , x = 196
      , y = 1571
      , height = 15
      , width = 57
      }
    , { text = "the"
      , x = 106
      , y = 1602
      , height = 15
      , width = 16
      }
    , { text = "last"
      , x = 125
      , y = 1602
      , height = 15
      , width = 18
      }
    , { text = "immemorial"
      , x = 146
      , y = 1602
      , height = 15
      , width = 64
      }
    , { text = "demon"
      , x = 213
      , y = 1602
      , height = 15
      , width = 36
      }
    , { text = "having"
      , x = 1
      , y = 1633
      , height = 15
      , width = 35
      }
    , { text = "from"
      , x = 51
      , y = 1648
      , height = 15
      , width = 25
      }
    , { text = "null"
      , x = 80
      , y = 1648
      , height = 15
      , width = 20
      }
    , { text = "regions"
      , x = 103
      , y = 1648
      , height = 15
      , width = 38
      }
    , { text = "induced"
      , x = 126
      , y = 1663
      , height = 15
      , width = 41
      }
    , { text = "the"
      , x = 1
      , y = 1678
      , height = 15
      , width = 16
      }
    , { text = "old"
      , x = 20
      , y = 1678
      , height = 15
      , width = 17
      }
    , { text = "man"
      , x = 40
      , y = 1678
      , height = 15
      , width = 22
      }
    , { text = "towards"
      , x = 66
      , y = 1678
      , height = 15
      , width = 41
      }
    , { text = "this"
      , x = 110
      , y = 1678
      , height = 15
      , width = 19
      }
    , { text = "supreme"
      , x = 132
      , y = 1678
      , height = 15
      , width = 44
      }
    , { text = "conjunction"
      , x = 179
      , y = 1678
      , height = 15
      , width = 62
      }
    , { text = "with"
      , x = 244
      , y = 1678
      , height = 15
      , width = 23
      }
    , { text = "probability"
      , x = 270
      , y = 1678
      , height = 15
      , width = 57
      }
    , { text = "he"
      , x = 176
      , y = 1709
      , height = 15
      , width = 12
      }
    , { text = "his"
      , x = 201
      , y = 1724
      , height = 15
      , width = 15
      }
    , { text = "puerile"
      , x = 219
      , y = 1724
      , height = 15
      , width = 37
      }
    , { text = "shade"
      , x = 259
      , y = 1724
      , height = 15
      , width = 29
      }
    , { text = "caressed"
      , x = 1
      , y = 1739
      , height = 15
      , width = 44
      }
    , { text = "and"
      , x = 48
      , y = 1739
      , height = 15
      , width = 19
      }
    , { text = "polished"
      , x = 70
      , y = 1739
      , height = 15
      , width = 44
      }
    , { text = "and"
      , x = 118
      , y = 1739
      , height = 15
      , width = 18
      }
    , { text = "rendered"
      , x = 140
      , y = 1739
      , height = 15
      , width = 45
      }
    , { text = "and"
      , x = 188
      , y = 1739
      , height = 15
      , width = 19
      }
    , { text = "laved"
      , x = 210
      , y = 1739
      , height = 15
      , width = 29
      }
    , { text = "made"
      , x = 126
      , y = 1754
      , height = 15
      , width = 28
      }
    , { text = "supple"
      , x = 157
      , y = 1754
      , height = 15
      , width = 34
      }
    , { text = "by"
      , x = 195
      , y = 1754
      , height = 15
      , width = 13
      }
    , { text = "the"
      , x = 211
      , y = 1754
      , height = 15
      , width = 16
      }
    , { text = "wave"
      , x = 230
      , y = 1754
      , height = 15
      , width = 27
      }
    , { text = "and"
      , x = 261
      , y = 1754
      , height = 15
      , width = 18
      }
    , { text = "abstracted"
      , x = 283
      , y = 1754
      , height = 15
      , width = 52
      }
    , { text = "from"
      , x = 101
      , y = 1769
      , height = 15
      , width = 25
      }
    , { text = "the"
      , x = 130
      , y = 1769
      , height = 15
      , width = 15
      }
    , { text = "hard"
      , x = 149
      , y = 1769
      , height = 15
      , width = 23
      }
    , { text = "bones"
      , x = 175
      , y = 1769
      , height = 15
      , width = 30
      }
    , { text = "lost"
      , x = 209
      , y = 1769
      , height = 15
      , width = 18
      }
    , { text = "between"
      , x = 231
      , y = 1769
      , height = 15
      , width = 43
      }
    , { text = "the"
      , x = 277
      , y = 1769
      , height = 15
      , width = 16
      }
    , { text = "planks"
      , x = 296
      , y = 1769
      , height = 15
      , width = 34
      }
    , { text = "born"
      , x = 161
      , y = 1800
      , height = 15
      , width = 24
      }
    , { text = "of"
      , x = 196
      , y = 1815
      , height = 15
      , width = 11
      }
    , { text = "a"
      , x = 210
      , y = 1815
      , height = 15
      , width = 6
      }
    , { text = "gambol"
      , x = 219
      , y = 1815
      , height = 15
      , width = 39
      }
    , { text = "the"
      , x = 1
      , y = 1846
      , height = 15
      , width = 16
      }
    , { text = "sea"
      , x = 20
      , y = 1846
      , height = 15
      , width = 17
      }
    , { text = "with"
      , x = 40
      , y = 1846
      , height = 15
      , width = 23
      }
    , { text = "the"
      , x = 66
      , y = 1846
      , height = 15
      , width = 16
      }
    , { text = "grandfather"
      , x = 86
      , y = 1846
      , height = 15
      , width = 59
      }
    , { text = "tempting"
      , x = 149
      , y = 1846
      , height = 15
      , width = 46
      }
    , { text = "or"
      , x = 198
      , y = 1846
      , height = 15
      , width = 11
      }
    , { text = "the"
      , x = 212
      , y = 1846
      , height = 15
      , width = 16
      }
    , { text = "grandfather"
      , x = 231
      , y = 1846
      , height = 15
      , width = 60
      }
    , { text = "against"
      , x = 295
      , y = 1846
      , height = 15
      , width = 36
      }
    , { text = "the"
      , x = 335
      , y = 1846
      , height = 15
      , width = 16
      }
    , { text = "sea"
      , x = 354
      , y = 1846
      , height = 15
      , width = 16
      }
    , { text = "an"
      , x = 76
      , y = 1861
      , height = 15
      , width = 12
      }
    , { text = "idle"
      , x = 92
      , y = 1861
      , height = 15
      , width = 19
      }
    , { text = "chance"
      , x = 114
      , y = 1861
      , height = 15
      , width = 36
      }
    , { text = "Betrothal"
      , x = 351
      , y = 1892
      , height = 15
      , width = 48
      }
    , { text = "whose"
      , x = 1
      , y = 1907
      , height = 15
      , width = 33
      }
    , { text = "veil"
      , x = 51
      , y = 1922
      , height = 15
      , width = 20
      }
    , { text = "of"
      , x = 74
      , y = 1922
      , height = 15
      , width = 11
      }
    , { text = "illusion"
      , x = 88
      , y = 1922
      , height = 15
      , width = 39
      }
    , { text = "gushed"
      , x = 130
      , y = 1922
      , height = 15
      , width = 37
      }
    , { text = "their"
      , x = 170
      , y = 1922
      , height = 15
      , width = 24
      }
    , { text = "phobia"
      , x = 197
      , y = 1922
      , height = 15
      , width = 36
      }
    , { text = "like"
      , x = 51
      , y = 1937
      , height = 15
      , width = 20
      }
    , { text = "the"
      , x = 74
      , y = 1937
      , height = 15
      , width = 16
      }
    , { text = "phantom"
      , x = 93
      , y = 1937
      , height = 15
      , width = 45
      }
    , { text = "of"
      , x = 142
      , y = 1937
      , height = 15
      , width = 10
      }
    , { text = "a"
      , x = 156
      , y = 1937
      , height = 15
      , width = 6
      }
    , { text = "gesture"
      , x = 165
      , y = 1937
      , height = 15
      , width = 37
      }
    , { text = "will"
      , x = 161
      , y = 1968
      , height = 15
      , width = 20
      }
    , { text = "totter"
      , x = 184
      , y = 1968
      , height = 15
      , width = 28
      }
    , { text = "will"
      , x = 161
      , y = 1983
      , height = 15
      , width = 20
      }
    , { text = "fall"
      , x = 184
      , y = 1983
      , height = 15
      , width = 18
      }
    , { text = "madness"
      , x = 251
      , y = 2024
      , height = 15
      , width = 45
      }
    , { text = "WILL"
      , x = 371
      , y = 2014
      , height = 28
      , width = 59
      }
    , { text = "ABOLISH"
      , x = 435
      , y = 2014
      , height = 28
      , width = 104
      }
    , { text = "AS"
      , x = 1
      , y = 2058
      , height = 18
      , width = 18
      }
    , { text = "IF"
      , x = 23
      , y = 2058
      , height = 18
      , width = 15
      }
    , { text = "an"
      , x = 181
      , y = 2092
      , height = 15
      , width = 13
      }
    , { text = "insinuation"
      , x = 197
      , y = 2092
      , height = 15
      , width = 58
      }
    , { text = "simple"
      , x = 259
      , y = 2092
      , height = 15
      , width = 33
      }
    , { text = "in"
      , x = 217
      , y = 2123
      , height = 15
      , width = 10
      }
    , { text = "silence"
      , x = 230
      , y = 2123
      , height = 15
      , width = 36
      }
    , { text = "rolled"
      , x = 270
      , y = 2123
      , height = 15
      , width = 30
      }
    , { text = "with"
      , x = 303
      , y = 2123
      , height = 15
      , width = 23
      }
    , { text = "irony"
      , x = 329
      , y = 2123
      , height = 15
      , width = 27
      }
    , { text = "or"
      , x = 368
      , y = 2138
      , height = 15
      , width = 12
      }
    , { text = "the"
      , x = 382
      , y = 2153
      , height = 15
      , width = 16
      }
    , { text = "mystery"
      , x = 401
      , y = 2153
      , height = 15
      , width = 40
      }
    , { text = "precipitated"
      , x = 393
      , y = 2168
      , height = 15
      , width = 62
      }
    , { text = "howled"
      , x = 468
      , y = 2183
      , height = 15
      , width = 37
      }
    , { text = "in"
      , x = 191
      , y = 2214
      , height = 15
      , width = 10
      }
    , { text = "some"
      , x = 205
      , y = 2214
      , height = 15
      , width = 26
      }
    , { text = "nearby"
      , x = 235
      , y = 2214
      , height = 15
      , width = 36
      }
    , { text = "whirlpool"
      , x = 274
      , y = 2214
      , height = 15
      , width = 51
      }
    , { text = "of"
      , x = 328
      , y = 2214
      , height = 15
      , width = 10
      }
    , { text = "hilarity"
      , x = 341
      , y = 2214
      , height = 15
      , width = 38
      }
    , { text = "or"
      , x = 383
      , y = 2214
      , height = 15
      , width = 11
      }
    , { text = "horror"
      , x = 398
      , y = 2214
      , height = 15
      , width = 34
      }
    , { text = "flutters"
      , x = 227
      , y = 2245
      , height = 15
      , width = 36
      }
    , { text = "around"
      , x = 266
      , y = 2245
      , height = 15
      , width = 37
      }
    , { text = "the"
      , x = 307
      , y = 2245
      , height = 15
      , width = 16
      }
    , { text = "gulf"
      , x = 326
      , y = 2245
      , height = 15
      , width = 20
      }
    , { text = "without"
      , x = 360
      , y = 2276
      , height = 15
      , width = 39
      }
    , { text = "strewing"
      , x = 402
      , y = 2276
      , height = 15
      , width = 45
      }
    , { text = "it"
      , x = 450
      , y = 2276
      , height = 15
      , width = 7
      }
    , { text = "nor"
      , x = 476
      , y = 2291
      , height = 15
      , width = 18
      }
    , { text = "fleeing"
      , x = 497
      , y = 2291
      , height = 15
      , width = 35
      }
    , { text = "and"
      , x = 347
      , y = 2322
      , height = 15
      , width = 19
      }
    , { text = "cradles"
      , x = 369
      , y = 2322
      , height = 15
      , width = 39
      }
    , { text = "the"
      , x = 411
      , y = 2322
      , height = 15
      , width = 16
      }
    , { text = "virgin"
      , x = 430
      , y = 2322
      , height = 15
      , width = 31
      }
    , { text = "index"
      , x = 464
      , y = 2322
      , height = 15
      , width = 28
      }
    , { text = "AS"
      , x = 535
      , y = 2353
      , height = 18
      , width = 18
      }
    , { text = "IF"
      , x = 557
      , y = 2353
      , height = 18
      , width = 15
      }
    , { text = "plume"
      , x = 51
      , y = 2387
      , height = 15
      , width = 32
      }
    , { text = "solitary"
      , x = 86
      , y = 2387
      , height = 15
      , width = 40
      }
    , { text = "distraught"
      , x = 129
      , y = 2387
      , height = 15
      , width = 53
      }
    , { text = "save"
      , x = 214
      , y = 2486
      , height = 15
      , width = 23
      }
    , { text = "that"
      , x = 240
      , y = 2486
      , height = 15
      , width = 20
      }
    , { text = "encounters"
      , x = 264
      , y = 2486
      , height = 15
      , width = 57
      }
    , { text = "or"
      , x = 324
      , y = 2486
      , height = 15
      , width = 11
      }
    , { text = "skims"
      , x = 339
      , y = 2486
      , height = 15
      , width = 29
      }
    , { text = "it"
      , x = 371
      , y = 2486
      , height = 15
      , width = 7
      }
    , { text = "a"
      , x = 381
      , y = 2486
      , height = 15
      , width = 7
      }
    , { text = "midnight"
      , x = 391
      , y = 2486
      , height = 15
      , width = 46
      }
    , { text = "cap"
      , x = 441
      , y = 2486
      , height = 15
      , width = 18
      }
    , { text = "and"
      , x = 369
      , y = 2501
      , height = 15
      , width = 20
      }
    , { text = "immobilizes"
      , x = 392
      , y = 2501
      , height = 15
      , width = 62
      }
    , { text = "in"
      , x = 286
      , y = 2516
      , height = 15
      , width = 10
      }
    , { text = "velvet"
      , x = 299
      , y = 2516
      , height = 15
      , width = 30
      }
    , { text = "crumpled"
      , x = 333
      , y = 2516
      , height = 15
      , width = 49
      }
    , { text = "by"
      , x = 385
      , y = 2516
      , height = 15
      , width = 12
      }
    , { text = "a"
      , x = 401
      , y = 2516
      , height = 15
      , width = 6
      }
    , { text = "guffaw"
      , x = 410
      , y = 2516
      , height = 15
      , width = 36
      }
    , { text = "somber"
      , x = 449
      , y = 2516
      , height = 15
      , width = 38
      }
    , { text = "that"
      , x = 369
      , y = 2547
      , height = 15
      , width = 21
      }
    , { text = "rigid"
      , x = 393
      , y = 2547
      , height = 15
      , width = 25
      }
    , { text = "whiteness"
      , x = 421
      , y = 2547
      , height = 15
      , width = 51
      }
    , { text = "derisory"
      , x = 201
      , y = 2578
      , height = 15
      , width = 43
      }
    , { text = "in"
      , x = 411
      , y = 2609
      , height = 15
      , width = 10
      }
    , { text = "opposition"
      , x = 425
      , y = 2609
      , height = 15
      , width = 55
      }
    , { text = "to"
      , x = 483
      , y = 2609
      , height = 15
      , width = 10
      }
    , { text = "the"
      , x = 496
      , y = 2609
      , height = 15
      , width = 16
      }
    , { text = "sky"
      , x = 515
      , y = 2609
      , height = 15
      , width = 17
      }
    , { text = "too"
      , x = 274
      , y = 2640
      , height = 15
      , width = 17
      }
    , { text = "much"
      , x = 294
      , y = 2640
      , height = 15
      , width = 28
      }
    , { text = "for"
      , x = 390
      , y = 2655
      , height = 15
      , width = 16
      }
    , { text = "not"
      , x = 409
      , y = 2655
      , height = 15
      , width = 16
      }
    , { text = "marking"
      , x = 429
      , y = 2655
      , height = 15
      , width = 43
      }
    , { text = "exiguously"
      , x = 441
      , y = 2670
      , height = 15
      , width = 56
      }
    , { text = "whosoever"
      , x = 466
      , y = 2685
      , height = 15
      , width = 56
      }
    , { text = "bitter"
      , x = 372
      , y = 2716
      , height = 15
      , width = 28
      }
    , { text = "prince"
      , x = 403
      , y = 2716
      , height = 15
      , width = 33
      }
    , { text = "of"
      , x = 440
      , y = 2716
      , height = 15
      , width = 10
      }
    , { text = "the"
      , x = 453
      , y = 2716
      , height = 15
      , width = 16
      }
    , { text = "reef"
      , x = 472
      , y = 2716
      , height = 15
      , width = 20
      }
    , { text = "puts"
      , x = 421
      , y = 2747
      , height = 15
      , width = 22
      }
    , { text = "it"
      , x = 446
      , y = 2747
      , height = 15
      , width = 8
      }
    , { text = "on"
      , x = 457
      , y = 2747
      , height = 15
      , width = 13
      }
    , { text = "like"
      , x = 473
      , y = 2747
      , height = 15
      , width = 19
      }
    , { text = "the"
      , x = 495
      , y = 2747
      , height = 15
      , width = 16
      }
    , { text = "heroic"
      , x = 514
      , y = 2747
      , height = 15
      , width = 33
      }
    , { text = "irresistible"
      , x = 407
      , y = 2762
      , height = 15
      , width = 56
      }
    , { text = "but"
      , x = 466
      , y = 2762
      , height = 15
      , width = 16
      }
    , { text = "contained"
      , x = 486
      , y = 2762
      , height = 15
      , width = 51
      }
    , { text = "by"
      , x = 400
      , y = 2777
      , height = 15
      , width = 13
      }
    , { text = "his"
      , x = 416
      , y = 2777
      , height = 15
      , width = 15
      }
    , { text = "little"
      , x = 434
      , y = 2777
      , height = 15
      , width = 24
      }
    , { text = "reason"
      , x = 461
      , y = 2777
      , height = 15
      , width = 35
      }
    , { text = "virile"
      , x = 500
      , y = 2777
      , height = 15
      , width = 27
      }
    , { text = "in"
      , x = 512
      , y = 2792
      , height = 15
      , width = 10
      }
    , { text = "lightning"
      , x = 525
      , y = 2792
      , height = 15
      , width = 47
      }
    , { text = "concerned"
      , x = 1
      , y = 2823
      , height = 15
      , width = 54
      }
    , { text = "expiatory"
      , x = 76
      , y = 2838
      , height = 15
      , width = 49
      }
    , { text = "and"
      , x = 128
      , y = 2838
      , height = 15
      , width = 20
      }
    , { text = "pubescent"
      , x = 151
      , y = 2838
      , height = 15
      , width = 52
      }
    , { text = "mute"
      , x = 251
      , y = 2853
      , height = 15
      , width = 25
      }
    , { text = "laughter"
      , x = 351
      , y = 2853
      , height = 15
      , width = 44
      }
    , { text = "that"
      , x = 432
      , y = 2884
      , height = 15
      , width = 20
      }
    , { text = "IF"
      , x = 477
      , y = 2915
      , height = 18
      , width = 15
      }
    , { text = "The"
      , x = 73
      , y = 2964
      , height = 15
      , width = 19
      }
    , { text = "lucid"
      , x = 95
      , y = 2964
      , height = 15
      , width = 26
      }
    , { text = "and"
      , x = 125
      , y = 2964
      , height = 15
      , width = 19
      }
    , { text = "seigniorial"
      , x = 147
      , y = 2964
      , height = 15
      , width = 57
      }
    , { text = "aigrette"
      , x = 207
      , y = 2964
      , height = 15
      , width = 40
      }
    , { text = "of"
      , x = 250
      , y = 2964
      , height = 15
      , width = 10
      }
    , { text = "vertigo"
      , x = 264
      , y = 2964
      , height = 15
      , width = 36
      }
    , { text = "with"
      , x = 112
      , y = 2979
      , height = 15
      , width = 22
      }
    , { text = "invisible"
      , x = 138
      , y = 2979
      , height = 15
      , width = 44
      }
    , { text = "brow"
      , x = 185
      , y = 2979
      , height = 15
      , width = 26
      }
    , { text = "scintillates"
      , x = 96
      , y = 2994
      , height = 15
      , width = 56
      }
    , { text = "then"
      , x = 151
      , y = 3009
      , height = 15
      , width = 23
      }
    , { text = "shadows"
      , x = 177
      , y = 3009
      , height = 15
      , width = 45
      }
    , { text = "a"
      , x = 130
      , y = 3024
      , height = 15
      , width = 6
      }
    , { text = "stature"
      , x = 139
      , y = 3024
      , height = 15
      , width = 36
      }
    , { text = "dainty"
      , x = 178
      , y = 3024
      , height = 15
      , width = 33
      }
    , { text = "tenebrous"
      , x = 214
      , y = 3024
      , height = 15
      , width = 51
      }
    , { text = "erect"
      , x = 268
      , y = 3024
      , height = 15
      , width = 25
      }
    , { text = "in"
      , x = 138
      , y = 3039
      , height = 15
      , width = 10
      }
    , { text = "its"
      , x = 151
      , y = 3039
      , height = 15
      , width = 12
      }
    , { text = "siren"
      , x = 167
      , y = 3039
      , height = 15
      , width = 25
      }
    , { text = "torsion"
      , x = 195
      , y = 3039
      , height = 15
      , width = 37
      }
    , { text = "time"
      , x = 313
      , y = 3054
      , height = 15
      , width = 22
      }
    , { text = "to"
      , x = 319
      , y = 3069
      , height = 15
      , width = 10
      }
    , { text = "slap"
      , x = 332
      , y = 3069
      , height = 15
      , width = 22
      }
    , { text = "with"
      , x = 106
      , y = 3084
      , height = 15
      , width = 22
      }
    , { text = "impatient"
      , x = 131
      , y = 3084
      , height = 15
      , width = 49
      }
    , { text = "scales"
      , x = 184
      , y = 3084
      , height = 15
      , width = 31
      }
    , { text = "ultimate"
      , x = 219
      , y = 3084
      , height = 15
      , width = 42
      }
    , { text = "bifurcated"
      , x = 264
      , y = 3084
      , height = 15
      , width = 53
      }
    , { text = "a"
      , x = 380
      , y = 3115
      , height = 15
      , width = 6
      }
    , { text = "rock"
      , x = 389
      , y = 3115
      , height = 15
      , width = 23
      }
    , { text = "false"
      , x = 320
      , y = 3146
      , height = 15
      , width = 25
      }
    , { text = "manor"
      , x = 348
      , y = 3146
      , height = 15
      , width = 34
      }
    , { text = "right"
      , x = 351
      , y = 3161
      , height = 15
      , width = 25
      }
    , { text = "away"
      , x = 380
      , y = 3161
      , height = 15
      , width = 27
      }
    , { text = "evaporated"
      , x = 395
      , y = 3176
      , height = 15
      , width = 59
      }
    , { text = "in"
      , x = 457
      , y = 3176
      , height = 15
      , width = 10
      }
    , { text = "mists"
      , x = 470
      , y = 3176
      , height = 15
      , width = 27
      }
    , { text = "that"
      , x = 390
      , y = 3207
      , height = 15
      , width = 20
      }
    , { text = "imposed"
      , x = 414
      , y = 3207
      , height = 15
      , width = 43
      }
    , { text = "a"
      , x = 443
      , y = 3222
      , height = 15
      , width = 6
      }
    , { text = "limit"
      , x = 453
      , y = 3222
      , height = 15
      , width = 23
      }
    , { text = "on"
      , x = 480
      , y = 3222
      , height = 15
      , width = 13
      }
    , { text = "infinity"
      , x = 496
      , y = 3222
      , height = 15
      , width = 36
      }
    , { text = "IT"
      , x = 138
      , y = 3253
      , height = 18
      , width = 14
      }
    , { text = "WAS"
      , x = 155
      , y = 3253
      , height = 18
      , width = 30
      }
    , { text = "stellar"
      , x = 135
      , y = 3273
      , height = 15
      , width = 34
      }
    , { text = "issue"
      , x = 172
      , y = 3273
      , height = 15
      , width = 26
      }
    , { text = "NUMBER"
      , x = 373
      , y = 3271
      , height = 18
      , width = 65
      }
    , { text = "EXISTED"
      , x = 365
      , y = 3305
      , height = 18
      , width = 67
      }
    , { text = "HE"
      , x = 436
      , y = 3305
      , height = 18
      , width = 21
      }
    , { text = "otherwise"
      , x = 343
      , y = 3323
      , height = 13
      , width = 39
      }
    , { text = "than"
      , x = 384
      , y = 3323
      , height = 13
      , width = 17
      }
    , { text = "scattered"
      , x = 404
      , y = 3323
      , height = 13
      , width = 35
      }
    , { text = "hallucination"
      , x = 442
      , y = 3323
      , height = 13
      , width = 52
      }
    , { text = "of"
      , x = 497
      , y = 3323
      , height = 13
      , width = 8
      }
    , { text = "agony"
      , x = 508
      , y = 3323
      , height = 13
      , width = 24
      }
    , { text = "COMMENCED"
      , x = 273
      , y = 3352
      , height = 18
      , width = 104
      }
    , { text = "HE"
      , x = 381
      , y = 3352
      , height = 18
      , width = 22
      }
    , { text = "AND"
      , x = 406
      , y = 3352
      , height = 18
      , width = 34
      }
    , { text = "CEASED"
      , x = 444
      , y = 3352
      , height = 18
      , width = 63
      }
    , { text = "HE"
      , x = 511
      , y = 3352
      , height = 18
      , width = 21
      }
    , { text = "upwelling"
      , x = 316
      , y = 3370
      , height = 13
      , width = 40
      }
    , { text = "but"
      , x = 359
      , y = 3370
      , height = 13
      , width = 13
      }
    , { text = "denied"
      , x = 374
      , y = 3370
      , height = 13
      , width = 27
      }
    , { text = "and"
      , x = 403
      , y = 3370
      , height = 13
      , width = 15
      }
    , { text = "closed"
      , x = 420
      , y = 3370
      , height = 13
      , width = 26
      }
    , { text = "when"
      , x = 448
      , y = 3370
      , height = 13
      , width = 22
      }
    , { text = "apparent"
      , x = 473
      , y = 3370
      , height = 13
      , width = 34
      }
    , { text = "at"
      , x = 333
      , y = 3383
      , height = 13
      , width = 8
      }
    , { text = "last"
      , x = 343
      , y = 3383
      , height = 13
      , width = 14
      }
    , { text = "by"
      , x = 325
      , y = 3396
      , height = 13
      , width = 10
      }
    , { text = "some"
      , x = 338
      , y = 3396
      , height = 13
      , width = 21
      }
    , { text = "profusion"
      , x = 361
      , y = 3396
      , height = 13
      , width = 39
      }
    , { text = "widespread"
      , x = 402
      , y = 3396
      , height = 13
      , width = 46
      }
    , { text = "in"
      , x = 450
      , y = 3396
      , height = 13
      , width = 8
      }
    , { text = "rarity"
      , x = 460
      , y = 3396
      , height = 13
      , width = 22
      }
    , { text = "CIPHERED"
      , x = 363
      , y = 3409
      , height = 18
      , width = 79
      }
    , { text = "HE"
      , x = 446
      , y = 3409
      , height = 18
      , width = 21
      }
    , { text = "evidence"
      , x = 306
      , y = 3447
      , height = 13
      , width = 35
      }
    , { text = "of"
      , x = 344
      , y = 3447
      , height = 13
      , width = 8
      }
    , { text = "the"
      , x = 355
      , y = 3447
      , height = 13
      , width = 12
      }
    , { text = "sum"
      , x = 369
      , y = 3447
      , height = 13
      , width = 17
      }
    , { text = "if"
      , x = 389
      , y = 3447
      , height = 13
      , width = 6
      }
    , { text = "only"
      , x = 397
      , y = 3447
      , height = 13
      , width = 18
      }
    , { text = "one"
      , x = 418
      , y = 3447
      , height = 13
      , width = 14
      }
    , { text = "ILLUMINATED"
      , x = 373
      , y = 3461
      , height = 18
      , width = 109
      }
    , { text = "HE"
      , x = 486
      , y = 3461
      , height = 18
      , width = 21
      }
    , { text = "IT"
      , x = 1
      , y = 3495
      , height = 18
      , width = 14
      }
    , { text = "WOULD"
      , x = 19
      , y = 3495
      , height = 18
      , width = 57
      }
    , { text = "BE"
      , x = 80
      , y = 3495
      , height = 18
      , width = 19
      }
    , { text = "worse"
      , x = 51
      , y = 3513
      , height = 13
      , width = 24
      }
    , { text = "no"
      , x = 126
      , y = 3526
      , height = 13
      , width = 10
      }
    , { text = "more"
      , x = 151
      , y = 3539
      , height = 13
      , width = 20
      }
    , { text = "nor"
      , x = 174
      , y = 3539
      , height = 13
      , width = 14
      }
    , { text = "less"
      , x = 190
      , y = 3539
      , height = 13
      , width = 15
      }
    , { text = "indifferently"
      , x = 101
      , y = 3564
      , height = 13
      , width = 49
      }
    , { text = "but"
      , x = 152
      , y = 3564
      , height = 13
      , width = 13
      }
    , { text = "as"
      , x = 167
      , y = 3564
      , height = 13
      , width = 9
      }
    , { text = "much"
      , x = 179
      , y = 3564
      , height = 13
      , width = 21
      }
    , { text = "CHANCE"
      , x = 275
      , y = 3552
      , height = 28
      , width = 99
      }
    , { text = "Falls"
      , x = 230
      , y = 3630
      , height = 15
      , width = 27
      }
    , { text = "the"
      , x = 261
      , y = 3645
      , height = 15
      , width = 16
      }
    , { text = "plume"
      , x = 280
      , y = 3645
      , height = 15
      , width = 32
      }
    , { text = "rhythmic"
      , x = 322
      , y = 3660
      , height = 15
      , width = 46
      }
    , { text = "suspense"
      , x = 372
      , y = 3660
      , height = 15
      , width = 46
      }
    , { text = "of"
      , x = 421
      , y = 3660
      , height = 15
      , width = 10
      }
    , { text = "the"
      , x = 435
      , y = 3660
      , height = 15
      , width = 15
      }
    , { text = "sinister"
      , x = 454
      , y = 3660
      , height = 15
      , width = 38
      }
    , { text = "to"
      , x = 481
      , y = 3675
      , height = 15
      , width = 10
      }
    , { text = "bury"
      , x = 495
      , y = 3675
      , height = 15
      , width = 23
      }
    , { text = "itself"
      , x = 522
      , y = 3675
      , height = 15
      , width = 25
      }
    , { text = "in"
      , x = 467
      , y = 3690
      , height = 15
      , width = 11
      }
    , { text = "original"
      , x = 481
      , y = 3690
      , height = 15
      , width = 42
      }
    , { text = "foams"
      , x = 526
      , y = 3690
      , height = 15
      , width = 31
      }
    , { text = "not"
      , x = 275
      , y = 3705
      , height = 15
      , width = 16
      }
    , { text = "long"
      , x = 294
      , y = 3705
      , height = 15
      , width = 24
      }
    , { text = "ago"
      , x = 321
      , y = 3705
      , height = 15
      , width = 19
      }
    , { text = "whence"
      , x = 344
      , y = 3705
      , height = 15
      , width = 39
      }
    , { text = "sprang"
      , x = 386
      , y = 3705
      , height = 15
      , width = 36
      }
    , { text = "up"
      , x = 425
      , y = 3705
      , height = 15
      , width = 13
      }
    , { text = "its"
      , x = 441
      , y = 3705
      , height = 15
      , width = 13
      }
    , { text = "delirium"
      , x = 457
      , y = 3705
      , height = 15
      , width = 44
      }
    , { text = "to"
      , x = 504
      , y = 3705
      , height = 15
      , width = 10
      }
    , { text = "a"
      , x = 518
      , y = 3705
      , height = 15
      , width = 6
      }
    , { text = "peak"
      , x = 527
      , y = 3705
      , height = 15
      , width = 25
      }
    , { text = "withered"
      , x = 467
      , y = 3720
      , height = 15
      , width = 45
      }
    , { text = "by"
      , x = 342
      , y = 3735
      , height = 15
      , width = 12
      }
    , { text = "the"
      , x = 358
      , y = 3735
      , height = 15
      , width = 15
      }
    , { text = "identical"
      , x = 377
      , y = 3735
      , height = 15
      , width = 45
      }
    , { text = "neutrality"
      , x = 425
      , y = 3735
      , height = 15
      , width = 51
      }
    , { text = "of"
      , x = 479
      , y = 3735
      , height = 15
      , width = 10
      }
    , { text = "the"
      , x = 493
      , y = 3735
      , height = 15
      , width = 16
      }
    , { text = "gulf"
      , x = 512
      , y = 3735
      , height = 15
      , width = 20
      }
    , { text = "NOTHING"
      , x = 1
      , y = 4072
      , height = 18
      , width = 73
      }
    , { text = "of"
      , x = 101
      , y = 4140
      , height = 15
      , width = 11
      }
    , { text = "the"
      , x = 115
      , y = 4140
      , height = 15
      , width = 16
      }
    , { text = "memorable"
      , x = 134
      , y = 4140
      , height = 15
      , width = 59
      }
    , { text = "crisis"
      , x = 196
      , y = 4140
      , height = 15
      , width = 27
      }
    , { text = "when"
      , x = 151
      , y = 4155
      , height = 15
      , width = 28
      }
    , { text = "might"
      , x = 182
      , y = 4155
      , height = 15
      , width = 31
      }
    , { text = "the"
      , x = 176
      , y = 4170
      , height = 15
      , width = 16
      }
    , { text = "event"
      , x = 195
      , y = 4170
      , height = 15
      , width = 28
      }
    , { text = "have"
      , x = 227
      , y = 4170
      , height = 15
      , width = 24
      }
    , { text = "been"
      , x = 254
      , y = 4170
      , height = 15
      , width = 25
      }
    , { text = "accomplished"
      , x = 282
      , y = 4170
      , height = 15
      , width = 72
      }
    , { text = "in"
      , x = 357
      , y = 4170
      , height = 15
      , width = 10
      }
    , { text = "view"
      , x = 370
      , y = 4170
      , height = 15
      , width = 26
      }
    , { text = "of"
      , x = 399
      , y = 4170
      , height = 15
      , width = 11
      }
    , { text = "every"
      , x = 413
      , y = 4170
      , height = 15
      , width = 29
      }
    , { text = "result"
      , x = 445
      , y = 4170
      , height = 15
      , width = 29
      }
    , { text = "null"
      , x = 477
      , y = 4170
      , height = 15
      , width = 20
      }
    , { text = "human"
      , x = 526
      , y = 4185
      , height = 15
      , width = 35
      }
    , { text = "WILL"
      , x = 335
      , y = 4216
      , height = 18
      , width = 40
      }
    , { text = "HAVE"
      , x = 378
      , y = 4216
      , height = 18
      , width = 43
      }
    , { text = "TAKEN"
      , x = 425
      , y = 4216
      , height = 18
      , width = 52
      }
    , { text = "PLACE"
      , x = 481
      , y = 4216
      , height = 18
      , width = 51
      }
    , { text = "an"
      , x = 345
      , y = 4234
      , height = 15
      , width = 12
      }
    , { text = "ordinary"
      , x = 361
      , y = 4234
      , height = 15
      , width = 44
      }
    , { text = "elevation"
      , x = 408
      , y = 4234
      , height = 15
      , width = 47
      }
    , { text = "pours"
      , x = 459
      , y = 4234
      , height = 15
      , width = 29
      }
    , { text = "absence"
      , x = 491
      , y = 4234
      , height = 15
      , width = 41
      }
    , { text = "BUT"
      , x = 426
      , y = 4265
      , height = 18
      , width = 32
      }
    , { text = "THE"
      , x = 461
      , y = 4265
      , height = 18
      , width = 31
      }
    , { text = "PLACE"
      , x = 496
      , y = 4265
      , height = 18
      , width = 51
      }
    , { text = "inferior"
      , x = 280
      , y = 4283
      , height = 15
      , width = 39
      }
    , { text = "lapping"
      , x = 322
      , y = 4283
      , height = 15
      , width = 39
      }
    , { text = "whatsoever"
      , x = 364
      , y = 4283
      , height = 15
      , width = 60
      }
    , { text = "as"
      , x = 427
      , y = 4283
      , height = 15
      , width = 11
      }
    , { text = "if"
      , x = 441
      , y = 4283
      , height = 15
      , width = 8
      }
    , { text = "to"
      , x = 452
      , y = 4283
      , height = 15
      , width = 10
      }
    , { text = "disperse"
      , x = 465
      , y = 4283
      , height = 15
      , width = 43
      }
    , { text = "the"
      , x = 511
      , y = 4283
      , height = 15
      , width = 16
      }
    , { text = "act"
      , x = 530
      , y = 4283
      , height = 15
      , width = 16
      }
    , { text = "void"
      , x = 549
      , y = 4283
      , height = 15
      , width = 23
      }
    , { text = "abruptly"
      , x = 363
      , y = 4298
      , height = 15
      , width = 43
      }
    , { text = "which"
      , x = 409
      , y = 4298
      , height = 15
      , width = 32
      }
    , { text = "if"
      , x = 444
      , y = 4298
      , height = 15
      , width = 8
      }
    , { text = "not"
      , x = 455
      , y = 4298
      , height = 15
      , width = 17
      }
    , { text = "by"
      , x = 340
      , y = 4313
      , height = 15
      , width = 13
      }
    , { text = "its"
      , x = 356
      , y = 4313
      , height = 15
      , width = 12
      }
    , { text = "falsehood"
      , x = 371
      , y = 4313
      , height = 15
      , width = 51
      }
    , { text = "might"
      , x = 318
      , y = 4328
      , height = 15
      , width = 30
      }
    , { text = "have"
      , x = 352
      , y = 4328
      , height = 15
      , width = 24
      }
    , { text = "founded"
      , x = 379
      , y = 4328
      , height = 15
      , width = 43
      }
    , { text = "perdition"
      , x = 375
      , y = 4343
      , height = 15
      , width = 47
      }
    , { text = "in"
      , x = 215
      , y = 4374
      , height = 15
      , width = 10
      }
    , { text = "those"
      , x = 228
      , y = 4374
      , height = 15
      , width = 27
      }
    , { text = "regions"
      , x = 259
      , y = 4374
      , height = 15
      , width = 38
      }
    , { text = "of"
      , x = 326
      , y = 4389
      , height = 15
      , width = 11
      }
    , { text = "the"
      , x = 340
      , y = 4389
      , height = 15
      , width = 16
      }
    , { text = "wave"
      , x = 360
      , y = 4389
      , height = 15
      , width = 27
      }
    , { text = "in"
      , x = 423
      , y = 4404
      , height = 15
      , width = 10
      }
    , { text = "which"
      , x = 437
      , y = 4404
      , height = 15
      , width = 31
      }
    , { text = "all"
      , x = 472
      , y = 4404
      , height = 15
      , width = 13
      }
    , { text = "reality"
      , x = 488
      , y = 4404
      , height = 15
      , width = 33
      }
    , { text = "dissolves"
      , x = 524
      , y = 4404
      , height = 15
      , width = 48
      }
    , { text = "EXCEPT"
      , x = 1
      , y = 4435
      , height = 18
      , width = 60
      }
    , { text = "at"
      , x = 51
      , y = 4455
      , height = 15
      , width = 9
      }
    , { text = "the"
      , x = 64
      , y = 4455
      , height = 15
      , width = 16
      }
    , { text = "altitude"
      , x = 83
      , y = 4455
      , height = 15
      , width = 39
      }
    , { text = "PERHAPS"
      , x = 126
      , y = 4471
      , height = 18
      , width = 70
      }
    , { text = "as"
      , x = 176
      , y = 4489
      , height = 15
      , width = 11
      }
    , { text = "far"
      , x = 190
      , y = 4489
      , height = 15
      , width = 15
      }
    , { text = "as"
      , x = 208
      , y = 4489
      , height = 15
      , width = 11
      }
    , { text = "a"
      , x = 222
      , y = 4489
      , height = 15
      , width = 6
      }
    , { text = "place"
      , x = 231
      , y = 4489
      , height = 15
      , width = 27
      }
    , { text = "fuses"
      , x = 262
      , y = 4489
      , height = 15
      , width = 26
      }
    , { text = "with"
      , x = 292
      , y = 4489
      , height = 15
      , width = 23
      }
    , { text = "beyond"
      , x = 318
      , y = 4489
      , height = 15
      , width = 38
      }
    , { text = "apart"
      , x = 357
      , y = 4520
      , height = 15
      , width = 26
      }
    , { text = "from"
      , x = 386
      , y = 4520
      , height = 15
      , width = 25
      }
    , { text = "the"
      , x = 415
      , y = 4520
      , height = 15
      , width = 15
      }
    , { text = "interest"
      , x = 434
      , y = 4520
      , height = 15
      , width = 38
      }
    , { text = "as"
      , x = 316
      , y = 4535
      , height = 15
      , width = 11
      }
    , { text = "to"
      , x = 330
      , y = 4535
      , height = 15
      , width = 10
      }
    , { text = "it"
      , x = 343
      , y = 4535
      , height = 15
      , width = 7
      }
    , { text = "signaled"
      , x = 354
      , y = 4535
      , height = 15
      , width = 43
      }
    , { text = "in"
      , x = 505
      , y = 4550
      , height = 15
      , width = 10
      }
    , { text = "general"
      , x = 519
      , y = 4550
      , height = 15
      , width = 38
      }
    , { text = "according"
      , x = 263
      , y = 4565
      , height = 15
      , width = 51
      }
    , { text = "to"
      , x = 317
      , y = 4565
      , height = 15
      , width = 11
      }
    , { text = "such"
      , x = 331
      , y = 4565
      , height = 15
      , width = 24
      }
    , { text = "obliquity"
      , x = 358
      , y = 4565
      , height = 15
      , width = 47
      }
    , { text = "by"
      , x = 408
      , y = 4565
      , height = 15
      , width = 13
      }
    , { text = "such"
      , x = 424
      , y = 4565
      , height = 15
      , width = 24
      }
    , { text = "declivity"
      , x = 452
      , y = 4565
      , height = 15
      , width = 45
      }
    , { text = "of"
      , x = 511
      , y = 4580
      , height = 15
      , width = 10
      }
    , { text = "fires"
      , x = 525
      , y = 4580
      , height = 15
      , width = 22
      }
    , { text = "toward"
      , x = 286
      , y = 4595
      , height = 15
      , width = 36
      }
    , { text = "this"
      , x = 309
      , y = 4626
      , height = 15
      , width = 19
      }
    , { text = "must"
      , x = 331
      , y = 4626
      , height = 15
      , width = 25
      }
    , { text = "be"
      , x = 360
      , y = 4626
      , height = 15
      , width = 12
      }
    , { text = "the"
      , x = 335
      , y = 4641
      , height = 15
      , width = 16
      }
    , { text = "Septentrion"
      , x = 354
      , y = 4641
      , height = 15
      , width = 60
      }
    , { text = "also"
      , x = 417
      , y = 4641
      , height = 15
      , width = 21
      }
    , { text = "North"
      , x = 442
      , y = 4641
      , height = 15
      , width = 30
      }
    , { text = "A"
      , x = 428
      , y = 4672
      , height = 18
      , width = 11
      }
    , { text = "CONSTELLATION"
      , x = 442
      , y = 4672
      , height = 18
      , width = 130
      }
    , { text = "cold"
      , x = 328
      , y = 4706
      , height = 15
      , width = 22
      }
    , { text = "from"
      , x = 353
      , y = 4706
      , height = 15
      , width = 25
      }
    , { text = "forgetting"
      , x = 382
      , y = 4706
      , height = 15
      , width = 51
      }
    , { text = "and"
      , x = 436
      , y = 4706
      , height = 15
      , width = 19
      }
    , { text = "desuetude"
      , x = 458
      , y = 4706
      , height = 15
      , width = 52
      }
    , { text = "not"
      , x = 446
      , y = 4721
      , height = 15
      , width = 17
      }
    , { text = "so"
      , x = 466
      , y = 4721
      , height = 15
      , width = 12
      }
    , { text = "much"
      , x = 481
      , y = 4721
      , height = 15
      , width = 29
      }
    , { text = "that"
      , x = 398
      , y = 4736
      , height = 15
      , width = 19
      }
    , { text = "it"
      , x = 420
      , y = 4736
      , height = 15
      , width = 8
      }
    , { text = "does"
      , x = 431
      , y = 4736
      , height = 15
      , width = 24
      }
    , { text = "not"
      , x = 458
      , y = 4736
      , height = 15
      , width = 17
      }
    , { text = "enumerate"
      , x = 478
      , y = 4736
      , height = 15
      , width = 54
      }
    , { text = "on"
      , x = 382
      , y = 4751
      , height = 15
      , width = 13
      }
    , { text = "some"
      , x = 399
      , y = 4751
      , height = 15
      , width = 27
      }
    , { text = "surface"
      , x = 429
      , y = 4751
      , height = 15
      , width = 38
      }
    , { text = "vacant"
      , x = 470
      , y = 4751
      , height = 15
      , width = 34
      }
    , { text = "and"
      , x = 507
      , y = 4751
      , height = 15
      , width = 19
      }
    , { text = "superior"
      , x = 529
      , y = 4751
      , height = 15
      , width = 43
      }
    , { text = "the"
      , x = 398
      , y = 4766
      , height = 15
      , width = 16
      }
    , { text = "successive"
      , x = 417
      , y = 4766
      , height = 15
      , width = 55
      }
    , { text = "clash"
      , x = 475
      , y = 4766
      , height = 15
      , width = 27
      }
    , { text = "sidereally"
      , x = 471
      , y = 4781
      , height = 15
      , width = 51
      }
    , { text = "of"
      , x = 366
      , y = 4796
      , height = 15
      , width = 11
      }
    , { text = "a"
      , x = 380
      , y = 4796
      , height = 15
      , width = 6
      }
    , { text = "total"
      , x = 389
      , y = 4796
      , height = 15
      , width = 23
      }
    , { text = "count"
      , x = 415
      , y = 4796
      , height = 15
      , width = 29
      }
    , { text = "in"
      , x = 447
      , y = 4796
      , height = 15
      , width = 10
      }
    , { text = "formation"
      , x = 461
      , y = 4796
      , height = 15
      , width = 51
      }
    , { text = "watching"
      , x = 249
      , y = 4811
      , height = 15
      , width = 48
      }
    , { text = "doubting"
      , x = 311
      , y = 4826
      , height = 15
      , width = 46
      }
    , { text = "rolling"
      , x = 367
      , y = 4841
      , height = 15
      , width = 35
      }
    , { text = "shining"
      , x = 418
      , y = 4856
      , height = 15
      , width = 38
      }
    , { text = "and"
      , x = 459
      , y = 4856
      , height = 15
      , width = 19
      }
    , { text = "meditating"
      , x = 481
      , y = 4856
      , height = 15
      , width = 56
      }
    , { text = "before"
      , x = 476
      , y = 4887
      , height = 15
      , width = 33
      }
    , { text = "stopping"
      , x = 512
      , y = 4887
      , height = 15
      , width = 45
      }
    , { text = "at"
      , x = 384
      , y = 4902
      , height = 15
      , width = 10
      }
    , { text = "some"
      , x = 397
      , y = 4902
      , height = 15
      , width = 27
      }
    , { text = "last"
      , x = 428
      , y = 4902
      , height = 15
      , width = 18
      }
    , { text = "point"
      , x = 449
      , y = 4902
      , height = 15
      , width = 27
      }
    , { text = "that"
      , x = 479
      , y = 4902
      , height = 15
      , width = 19
      }
    , { text = "consecrates"
      , x = 502
      , y = 4902
      , height = 15
      , width = 60
      }
    , { text = "it"
      , x = 565
      , y = 4902
      , height = 15
      , width = 7
      }
    , { text = "Every"
      , x = 323
      , y = 4933
      , height = 15
      , width = 31
      }
    , { text = "Thought"
      , x = 358
      , y = 4933
      , height = 15
      , width = 44
      }
    , { text = "sends"
      , x = 405
      , y = 4933
      , height = 15
      , width = 29
      }
    , { text = "forth"
      , x = 437
      , y = 4933
      , height = 15
      , width = 25
      }
    , { text = "one"
      , x = 466
      , y = 4933
      , height = 15
      , width = 18
      }
    , { text = "Toss"
      , x = 487
      , y = 4933
      , height = 15
      , width = 24
      }
    , { text = "of"
      , x = 514
      , y = 4933
      , height = 15
      , width = 11
      }
    , { text = "the"
      , x = 528
      , y = 4933
      , height = 15
      , width = 16
      }
    , { text = "Dice"
      , x = 547
      , y = 4933
      , height = 15
      , width = 25
      }
    ]
