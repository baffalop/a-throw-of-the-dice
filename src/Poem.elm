module Poem exposing (..)

import List.Extra


type alias Word =
    { text : String
    , x : Int
    , y : Int
    , width : Int
    , height : Int
    }


words : List Word
words =
    [ { text = "ONE", x = 41, y = 69, height = 28, width = 49 }
    , { text = "TOSS", x = 96, y = 69, height = 28, width = 58 }
    , { text = "OF", x = 160, y = 69, height = 28, width = 31 }
    , { text = "THE", x = 197, y = 69, height = 28, width = 46 }
    , { text = "DICE", x = 249, y = 69, height = 28, width = 56 }
    , { text = "NEVER", x = 412, y = 113, height = 28, width = 80 }
    , { text = "NOT", x = 350, y = 157, height = 15, width = 26 }
    , { text = "EVEN", x = 380, y = 157, height = 15, width = 34 }
    , { text = "WHEN", x = 417, y = 157, height = 15, width = 39 }
    , { text = "CAST", x = 460, y = 157, height = 15, width = 33 }
    , { text = "IN", x = 496, y = 157, height = 15, width = 14 }
    , { text = "ETERNAL", x = 513, y = 157, height = 15, width = 59 }
    , { text = "CIRCUMSTANCES", x = 319, y = 172, height = 15, width = 108 }
    , { text = "FROM", x = 345, y = 203, height = 15, width = 37 }
    , { text = "THE", x = 385, y = 203, height = 15, width = 25 }
    , { text = "DEPTHS", x = 413, y = 203, height = 15, width = 50 }
    , { text = "OF", x = 466, y = 203, height = 15, width = 16 }
    , { text = "A", x = 485, y = 203, height = 15, width = 9 }
    , { text = "SHIPWRECK", x = 497, y = 203, height = 15, width = 75 }
    , { text = "WHETHER", x = 1, y = 268, height = 18, width = 78 }
    , { text = "the", x = 51, y = 286, height = 15, width = 16 }
    , { text = "Abyss", x = 81, y = 351, height = 15, width = 33 }
    , { text = "whitened", x = 1, y = 416, height = 15, width = 48 }
    , { text = "becalmed", x = 41, y = 447, height = 15, width = 50 }
    , { text = "furious", x = 81, y = 478, height = 15, width = 37 }
    , { text = "under", x = 121, y = 509, height = 15, width = 30 }
    , { text = "an", x = 154, y = 509, height = 15, width = 12 }
    , { text = "inclination", x = 169, y = 509, height = 15, width = 56 }
    , { text = "glides", x = 131, y = 524, height = 15, width = 31 }
    , { text = "desperately", x = 165, y = 524, height = 15, width = 59 }
    , { text = "with", x = 161, y = 589, height = 15, width = 23 }
    , { text = "wing", x = 187, y = 589, height = 15, width = 26 }
    , { text = "its", x = 144, y = 620, height = 15, width = 12 }
    , { text = "own", x = 160, y = 620, height = 15, width = 22 }
    , { text = "in", x = 248, y = 635, height = 15, width = 11 }
    , { text = "advance", x = 262, y = 635, height = 15, width = 42 }
    , { text = "refallen", x = 308, y = 635, height = 15, width = 39 }
    , { text = "with", x = 351, y = 635, height = 15, width = 23 }
    , { text = "a", x = 377, y = 635, height = 15, width = 6 }
    , { text = "difficulty", x = 386, y = 635, height = 15, width = 48 }
    , { text = "in", x = 437, y = 635, height = 15, width = 10 }
    , { text = "setting", x = 450, y = 635, height = 15, width = 35 }
    , { text = "up", x = 488, y = 635, height = 15, width = 13 }
    , { text = "flight", x = 505, y = 635, height = 15, width = 27 }
    , { text = "and", x = 380, y = 650, height = 15, width = 19 }
    , { text = "covering", x = 402, y = 650, height = 15, width = 45 }
    , { text = "the", x = 451, y = 650, height = 15, width = 16 }
    , { text = "outpourings", x = 470, y = 650, height = 15, width = 62 }
    , { text = "cutting", x = 410, y = 665, height = 15, width = 36 }
    , { text = "utterly", x = 449, y = 665, height = 15, width = 34 }
    , { text = "the", x = 486, y = 665, height = 15, width = 16 }
    , { text = "leaps", x = 505, y = 665, height = 15, width = 27 }
    , { text = "very", x = 331, y = 696, height = 15, width = 24 }
    , { text = "interiorly", x = 358, y = 696, height = 15, width = 48 }
    , { text = "resumes", x = 409, y = 696, height = 15, width = 43 }
    , { text = "the", x = 308, y = 727, height = 15, width = 16 }
    , { text = "shade", x = 327, y = 727, height = 15, width = 30 }
    , { text = "buried", x = 360, y = 727, height = 15, width = 33 }
    , { text = "in", x = 397, y = 727, height = 15, width = 10 }
    , { text = "the", x = 410, y = 727, height = 15, width = 16 }
    , { text = "deep", x = 429, y = 727, height = 15, width = 25 }
    , { text = "by", x = 457, y = 727, height = 15, width = 13 }
    , { text = "that", x = 473, y = 727, height = 15, width = 20 }
    , { text = "alternative", x = 496, y = 727, height = 15, width = 55 }
    , { text = "sail", x = 554, y = 727, height = 15, width = 18 }
    , { text = "as", x = 457, y = 758, height = 15, width = 11 }
    , { text = "to", x = 471, y = 758, height = 15, width = 10 }
    , { text = "adapt", x = 484, y = 758, height = 15, width = 29 }
    , { text = "to", x = 453, y = 773, height = 15, width = 10 }
    , { text = "its", x = 467, y = 773, height = 15, width = 12 }
    , { text = "wingspan", x = 482, y = 773, height = 15, width = 50 }
    , { text = "its", x = 352, y = 804, height = 15, width = 13 }
    , { text = "gaping", x = 368, y = 804, height = 15, width = 35 }
    , { text = "depth", x = 406, y = 804, height = 15, width = 29 }
    , { text = "as", x = 439, y = 804, height = 15, width = 10 }
    , { text = "the", x = 453, y = 804, height = 15, width = 16 }
    , { text = "hull", x = 472, y = 804, height = 15, width = 20 }
    , { text = "of", x = 437, y = 835, height = 15, width = 11 }
    , { text = "a", x = 451, y = 835, height = 15, width = 6 }
    , { text = "vessel", x = 460, y = 835, height = 15, width = 32 }
    , { text = "tilted", x = 382, y = 866, height = 15, width = 27 }
    , { text = "to", x = 412, y = 866, height = 15, width = 11 }
    , { text = "one", x = 426, y = 866, height = 15, width = 19 }
    , { text = "or", x = 448, y = 866, height = 15, width = 11 }
    , { text = "the", x = 462, y = 866, height = 15, width = 16 }
    , { text = "other", x = 481, y = 866, height = 15, width = 27 }
    , { text = "side", x = 511, y = 866, height = 15, width = 21 }
    , { text = "THE", x = 91, y = 897, height = 18, width = 31 }
    , { text = "MASTER", x = 126, y = 897, height = 18, width = 65 }
    , { text = "outside", x = 341, y = 899, height = 15, width = 38 }
    , { text = "old", x = 382, y = 899, height = 15, width = 16 }
    , { text = "calculations", x = 402, y = 899, height = 15, width = 62 }
    , { text = "where", x = 291, y = 915, height = 15, width = 32 }
    , { text = "the", x = 326, y = 915, height = 15, width = 16 }
    , { text = "maneuver", x = 345, y = 915, height = 15, width = 51 }
    , { text = "with", x = 400, y = 915, height = 15, width = 23 }
    , { text = "age", x = 426, y = 915, height = 15, width = 18 }
    , { text = "forgotten", x = 447, y = 915, height = 15, width = 48 }
    , { text = "arisen", x = 41, y = 946, height = 15, width = 31 }
    , { text = "inferring", x = 51, y = 961, height = 15, width = 45 }
    , { text = "long", x = 346, y = 961, height = 15, width = 23 }
    , { text = "ago", x = 373, y = 961, height = 15, width = 18 }
    , { text = "he", x = 395, y = 961, height = 15, width = 12 }
    , { text = "grasped", x = 410, y = 961, height = 15, width = 41 }
    , { text = "the", x = 454, y = 961, height = 15, width = 16 }
    , { text = "helm", x = 473, y = 961, height = 15, width = 26 }
    , { text = "of", x = 121, y = 992, height = 15, width = 11 }
    , { text = "that", x = 135, y = 992, height = 15, width = 20 }
    , { text = "conflagration", x = 158, y = 992, height = 15, width = 68 }
    , { text = "at", x = 230, y = 992, height = 15, width = 9 }
    , { text = "his", x = 242, y = 992, height = 15, width = 16 }
    , { text = "feet", x = 261, y = 992, height = 15, width = 19 }
    , { text = "of", x = 271, y = 1007, height = 15, width = 11 }
    , { text = "the", x = 285, y = 1007, height = 15, width = 16 }
    , { text = "unanimous", x = 304, y = 1007, height = 15, width = 57 }
    , { text = "horizon", x = 365, y = 1007, height = 15, width = 39 }
    , { text = "there", x = 231, y = 1038, height = 15, width = 26 }
    , { text = "is", x = 260, y = 1038, height = 15, width = 9 }
    , { text = "preparing", x = 272, y = 1038, height = 15, width = 50 }
    , { text = "stirring", x = 281, y = 1053, height = 15, width = 38 }
    , { text = "and", x = 322, y = 1053, height = 15, width = 19 }
    , { text = "mixing", x = 344, y = 1053, height = 15, width = 37 }
    , { text = "in", x = 306, y = 1068, height = 15, width = 10 }
    , { text = "the", x = 319, y = 1068, height = 15, width = 16 }
    , { text = "fist", x = 339, y = 1068, height = 15, width = 15 }
    , { text = "that", x = 358, y = 1068, height = 15, width = 19 }
    , { text = "might", x = 380, y = 1068, height = 15, width = 31 }
    , { text = "clutch", x = 414, y = 1068, height = 15, width = 32 }
    , { text = "it", x = 449, y = 1068, height = 15, width = 7 }
    , { text = "as", x = 156, y = 1083, height = 15, width = 11 }
    , { text = "one", x = 170, y = 1083, height = 15, width = 19 }
    , { text = "menaces", x = 192, y = 1083, height = 15, width = 45 }
    , { text = "a", x = 240, y = 1083, height = 15, width = 6 }
    , { text = "destiny", x = 249, y = 1083, height = 15, width = 38 }
    , { text = "and", x = 290, y = 1083, height = 15, width = 19 }
    , { text = "the", x = 312, y = 1083, height = 15, width = 16 }
    , { text = "winds", x = 331, y = 1083, height = 15, width = 31 }
    , { text = "the", x = 51, y = 1114, height = 15, width = 16 }
    , { text = "unique", x = 70, y = 1114, height = 15, width = 35 }
    , { text = "Number", x = 109, y = 1114, height = 15, width = 42 }
    , { text = "which", x = 154, y = 1114, height = 15, width = 32 }
    , { text = "cannot", x = 189, y = 1114, height = 15, width = 35 }
    , { text = "be", x = 227, y = 1114, height = 15, width = 13 }
    , { text = "another", x = 243, y = 1114, height = 15, width = 39 }
    , { text = "Spirit", x = 322, y = 1145, height = 15, width = 29 }
    , { text = "to", x = 364, y = 1160, height = 15, width = 10 }
    , { text = "hurl", x = 377, y = 1160, height = 15, width = 21 }
    , { text = "it", x = 402, y = 1160, height = 15, width = 7 }
    , { text = "in", x = 413, y = 1175, height = 15, width = 10 }
    , { text = "the", x = 426, y = 1175, height = 15, width = 16 }
    , { text = "tempest", x = 445, y = 1175, height = 15, width = 40 }
    , { text = "refolding", x = 319, y = 1190, height = 15, width = 48 }
    , { text = "the", x = 370, y = 1190, height = 15, width = 16 }
    , { text = "division", x = 389, y = 1190, height = 15, width = 42 }
    , { text = "and", x = 434, y = 1190, height = 15, width = 19 }
    , { text = "passing", x = 456, y = 1190, height = 15, width = 39 }
    , { text = "proud", x = 499, y = 1190, height = 15, width = 30 }
    , { text = "hesitates", x = 202, y = 1205, height = 15, width = 44 }
    , { text = "a", x = 150, y = 1220, height = 15, width = 6 }
    , { text = "corpse", x = 159, y = 1220, height = 15, width = 34 }
    , { text = "by", x = 196, y = 1220, height = 15, width = 13 }
    , { text = "the", x = 212, y = 1220, height = 15, width = 16 }
    , { text = "arm", x = 231, y = 1220, height = 15, width = 21 }
    , { text = "set", x = 255, y = 1220, height = 15, width = 14 }
    , { text = "apart", x = 273, y = 1220, height = 15, width = 26 }
    , { text = "from", x = 302, y = 1220, height = 15, width = 25 }
    , { text = "the", x = 330, y = 1220, height = 15, width = 16 }
    , { text = "secret", x = 350, y = 1220, height = 15, width = 30 }
    , { text = "it", x = 383, y = 1220, height = 15, width = 7 }
    , { text = "keeps", x = 394, y = 1220, height = 15, width = 29 }
    , { text = "rather", x = 9, y = 1235, height = 15, width = 30 }
    , { text = "than", x = 43, y = 1250, height = 15, width = 23 }
    , { text = "to", x = 69, y = 1250, height = 15, width = 10 }
    , { text = "play", x = 82, y = 1250, height = 15, width = 23 }
    , { text = "like", x = 73, y = 1265, height = 15, width = 19 }
    , { text = "a", x = 96, y = 1265, height = 15, width = 5 }
    , { text = "hoary", x = 105, y = 1265, height = 15, width = 29 }
    , { text = "maniac", x = 138, y = 1265, height = 15, width = 37 }
    , { text = "the", x = 131, y = 1280, height = 15, width = 16 }
    , { text = "game", x = 150, y = 1280, height = 15, width = 29 }
    , { text = "in", x = 81, y = 1295, height = 15, width = 10 }
    , { text = "the", x = 95, y = 1295, height = 15, width = 16 }
    , { text = "name", x = 114, y = 1295, height = 15, width = 28 }
    , { text = "of", x = 145, y = 1295, height = 15, width = 11 }
    , { text = "waves", x = 159, y = 1295, height = 15, width = 33 }
    , { text = "one", x = 244, y = 1310, height = 15, width = 19 }
    , { text = "invades", x = 266, y = 1310, height = 15, width = 40 }
    , { text = "the", x = 309, y = 1310, height = 15, width = 16 }
    , { text = "chief", x = 328, y = 1310, height = 15, width = 26 }
    , { text = "flows", x = 272, y = 1325, height = 15, width = 29 }
    , { text = "like", x = 304, y = 1325, height = 15, width = 19 }
    , { text = "a", x = 327, y = 1325, height = 15, width = 5 }
    , { text = "submissive", x = 336, y = 1325, height = 15, width = 57 }
    , { text = "beard", x = 397, y = 1325, height = 15, width = 29 }
    , { text = "shipwreck", x = 192, y = 1356, height = 15, width = 54 }
    , { text = "that", x = 249, y = 1356, height = 15, width = 20 }
    , { text = "direct", x = 272, y = 1356, height = 15, width = 29 }
    , { text = "from", x = 305, y = 1356, height = 15, width = 25 }
    , { text = "man", x = 333, y = 1356, height = 15, width = 23 }
    , { text = "sans", x = 310, y = 1387, height = 15, width = 22 }
    , { text = "ship", x = 335, y = 1387, height = 15, width = 22 }
    , { text = "no", x = 333, y = 1402, height = 15, width = 13 }
    , { text = "matter", x = 349, y = 1402, height = 15, width = 33 }
    , { text = "where", x = 410, y = 1433, height = 15, width = 31 }
    , { text = "vain", x = 445, y = 1433, height = 15, width = 22 }
    , { text = "ancestrally", x = 1, y = 1464, height = 15, width = 56 }
    , { text = "to", x = 61, y = 1464, height = 15, width = 10 }
    , { text = "not", x = 74, y = 1464, height = 15, width = 17 }
    , { text = "open", x = 94, y = 1464, height = 15, width = 25 }
    , { text = "the", x = 122, y = 1464, height = 15, width = 16 }
    , { text = "hand", x = 141, y = 1464, height = 15, width = 26 }
    , { text = "clenched", x = 126, y = 1479, height = 15, width = 46 }
    , { text = "beyond", x = 101, y = 1494, height = 15, width = 38 }
    , { text = "the", x = 143, y = 1494, height = 15, width = 15 }
    , { text = "useless", x = 162, y = 1494, height = 15, width = 37 }
    , { text = "head", x = 202, y = 1494, height = 15, width = 24 }
    , { text = "legacy", x = 41, y = 1525, height = 15, width = 34 }
    , { text = "in", x = 78, y = 1525, height = 15, width = 10 }
    , { text = "the", x = 92, y = 1525, height = 15, width = 15 }
    , { text = "disappearance", x = 111, y = 1525, height = 15, width = 73 }
    , { text = "to", x = 121, y = 1556, height = 15, width = 10 }
    , { text = "someone", x = 134, y = 1556, height = 15, width = 47 }
    , { text = "ambiguous", x = 196, y = 1571, height = 15, width = 57 }
    , { text = "the", x = 106, y = 1602, height = 15, width = 16 }
    , { text = "last", x = 125, y = 1602, height = 15, width = 18 }
    , { text = "immemorial", x = 146, y = 1602, height = 15, width = 64 }
    , { text = "demon", x = 213, y = 1602, height = 15, width = 36 }
    , { text = "having", x = 1, y = 1633, height = 15, width = 35 }
    , { text = "from", x = 51, y = 1648, height = 15, width = 25 }
    , { text = "null", x = 80, y = 1648, height = 15, width = 20 }
    , { text = "regions", x = 103, y = 1648, height = 15, width = 38 }
    , { text = "induced", x = 126, y = 1663, height = 15, width = 41 }
    , { text = "the", x = 1, y = 1678, height = 15, width = 16 }
    , { text = "old", x = 20, y = 1678, height = 15, width = 17 }
    , { text = "man", x = 40, y = 1678, height = 15, width = 22 }
    , { text = "towards", x = 66, y = 1678, height = 15, width = 41 }
    , { text = "this", x = 110, y = 1678, height = 15, width = 19 }
    , { text = "supreme", x = 132, y = 1678, height = 15, width = 44 }
    , { text = "conjunction", x = 179, y = 1678, height = 15, width = 62 }
    , { text = "with", x = 244, y = 1678, height = 15, width = 23 }
    , { text = "probability", x = 270, y = 1678, height = 15, width = 57 }
    , { text = "he", x = 176, y = 1709, height = 15, width = 12 }
    , { text = "his", x = 201, y = 1724, height = 15, width = 15 }
    , { text = "puerile", x = 219, y = 1724, height = 15, width = 37 }
    , { text = "shade", x = 259, y = 1724, height = 15, width = 29 }
    , { text = "caressed", x = 1, y = 1739, height = 15, width = 44 }
    , { text = "and", x = 48, y = 1739, height = 15, width = 19 }
    , { text = "polished", x = 70, y = 1739, height = 15, width = 44 }
    , { text = "and", x = 118, y = 1739, height = 15, width = 18 }
    , { text = "rendered", x = 140, y = 1739, height = 15, width = 45 }
    , { text = "and", x = 188, y = 1739, height = 15, width = 19 }
    , { text = "laved", x = 210, y = 1739, height = 15, width = 29 }
    , { text = "made", x = 126, y = 1754, height = 15, width = 28 }
    , { text = "supple", x = 157, y = 1754, height = 15, width = 34 }
    , { text = "by", x = 195, y = 1754, height = 15, width = 13 }
    , { text = "the", x = 211, y = 1754, height = 15, width = 16 }
    , { text = "wave", x = 230, y = 1754, height = 15, width = 27 }
    , { text = "and", x = 261, y = 1754, height = 15, width = 18 }
    , { text = "abstracted", x = 283, y = 1754, height = 15, width = 52 }
    , { text = "from", x = 101, y = 1769, height = 15, width = 25 }
    , { text = "the", x = 130, y = 1769, height = 15, width = 15 }
    , { text = "hard", x = 149, y = 1769, height = 15, width = 23 }
    , { text = "bones", x = 175, y = 1769, height = 15, width = 30 }
    , { text = "lost", x = 209, y = 1769, height = 15, width = 18 }
    , { text = "between", x = 231, y = 1769, height = 15, width = 43 }
    , { text = "the", x = 277, y = 1769, height = 15, width = 16 }
    , { text = "planks", x = 296, y = 1769, height = 15, width = 34 }
    , { text = "born", x = 161, y = 1800, height = 15, width = 24 }
    , { text = "of", x = 196, y = 1815, height = 15, width = 11 }
    , { text = "a", x = 210, y = 1815, height = 15, width = 6 }
    , { text = "gambol", x = 219, y = 1815, height = 15, width = 39 }
    , { text = "the", x = 1, y = 1846, height = 15, width = 16 }
    , { text = "sea", x = 20, y = 1846, height = 15, width = 17 }
    , { text = "with", x = 40, y = 1846, height = 15, width = 23 }
    , { text = "the", x = 66, y = 1846, height = 15, width = 16 }
    , { text = "grandfather", x = 86, y = 1846, height = 15, width = 59 }
    , { text = "tempting", x = 149, y = 1846, height = 15, width = 46 }
    , { text = "or", x = 198, y = 1846, height = 15, width = 11 }
    , { text = "the", x = 212, y = 1846, height = 15, width = 16 }
    , { text = "grandfather", x = 231, y = 1846, height = 15, width = 60 }
    , { text = "against", x = 295, y = 1846, height = 15, width = 36 }
    , { text = "the", x = 335, y = 1846, height = 15, width = 16 }
    , { text = "sea", x = 354, y = 1846, height = 15, width = 16 }
    , { text = "an", x = 76, y = 1861, height = 15, width = 12 }
    , { text = "idle", x = 92, y = 1861, height = 15, width = 19 }
    , { text = "chance", x = 114, y = 1861, height = 15, width = 36 }
    , { text = "Betrothal", x = 351, y = 1892, height = 15, width = 48 }
    , { text = "whose", x = 1, y = 1907, height = 15, width = 33 }
    , { text = "veil", x = 51, y = 1922, height = 15, width = 20 }
    , { text = "of", x = 74, y = 1922, height = 15, width = 11 }
    , { text = "illusion", x = 88, y = 1922, height = 15, width = 39 }
    , { text = "gushed", x = 130, y = 1922, height = 15, width = 37 }
    , { text = "their", x = 170, y = 1922, height = 15, width = 24 }
    , { text = "phobia", x = 197, y = 1922, height = 15, width = 36 }
    , { text = "like", x = 51, y = 1937, height = 15, width = 20 }
    , { text = "the", x = 74, y = 1937, height = 15, width = 16 }
    , { text = "phantom", x = 93, y = 1937, height = 15, width = 45 }
    , { text = "of", x = 142, y = 1937, height = 15, width = 10 }
    , { text = "a", x = 156, y = 1937, height = 15, width = 6 }
    , { text = "gesture", x = 165, y = 1937, height = 15, width = 37 }
    , { text = "will", x = 161, y = 1968, height = 15, width = 20 }
    , { text = "totter", x = 184, y = 1968, height = 15, width = 28 }
    , { text = "will", x = 161, y = 1983, height = 15, width = 20 }
    , { text = "fall", x = 184, y = 1983, height = 15, width = 18 }
    , { text = "madness", x = 251, y = 2024, height = 15, width = 45 }
    , { text = "WILL", x = 371, y = 2014, height = 28, width = 59 }
    , { text = "ABOLISH", x = 435, y = 2014, height = 28, width = 104 }
    , { text = "AS", x = 1, y = 2058, height = 18, width = 18 }
    , { text = "IF", x = 23, y = 2058, height = 18, width = 15 }
    , { text = "an", x = 181, y = 2092, height = 15, width = 13 }
    , { text = "insinuation", x = 197, y = 2092, height = 15, width = 58 }
    , { text = "simple", x = 259, y = 2092, height = 15, width = 33 }
    , { text = "in", x = 217, y = 2123, height = 15, width = 10 }
    , { text = "silence", x = 230, y = 2123, height = 15, width = 36 }
    , { text = "rolled", x = 270, y = 2123, height = 15, width = 30 }
    , { text = "with", x = 303, y = 2123, height = 15, width = 23 }
    , { text = "irony", x = 329, y = 2123, height = 15, width = 27 }
    , { text = "or", x = 368, y = 2138, height = 15, width = 12 }
    , { text = "the", x = 382, y = 2153, height = 15, width = 16 }
    , { text = "mystery", x = 401, y = 2153, height = 15, width = 40 }
    , { text = "precipitated", x = 393, y = 2168, height = 15, width = 62 }
    , { text = "howled", x = 468, y = 2183, height = 15, width = 37 }
    , { text = "in", x = 191, y = 2214, height = 15, width = 10 }
    , { text = "some", x = 205, y = 2214, height = 15, width = 26 }
    , { text = "nearby", x = 235, y = 2214, height = 15, width = 36 }
    , { text = "whirlpool", x = 274, y = 2214, height = 15, width = 51 }
    , { text = "of", x = 328, y = 2214, height = 15, width = 10 }
    , { text = "hilarity", x = 341, y = 2214, height = 15, width = 38 }
    , { text = "or", x = 383, y = 2214, height = 15, width = 11 }
    , { text = "horror", x = 398, y = 2214, height = 15, width = 34 }
    , { text = "flutters", x = 227, y = 2245, height = 15, width = 36 }
    , { text = "around", x = 266, y = 2245, height = 15, width = 37 }
    , { text = "the", x = 307, y = 2245, height = 15, width = 16 }
    , { text = "gulf", x = 326, y = 2245, height = 15, width = 20 }
    , { text = "without", x = 360, y = 2276, height = 15, width = 39 }
    , { text = "strewing", x = 402, y = 2276, height = 15, width = 45 }
    , { text = "it", x = 450, y = 2276, height = 15, width = 7 }
    , { text = "nor", x = 476, y = 2291, height = 15, width = 18 }
    , { text = "fleeing", x = 497, y = 2291, height = 15, width = 35 }
    , { text = "and", x = 347, y = 2322, height = 15, width = 19 }
    , { text = "cradles", x = 369, y = 2322, height = 15, width = 39 }
    , { text = "the", x = 411, y = 2322, height = 15, width = 16 }
    , { text = "virgin", x = 430, y = 2322, height = 15, width = 31 }
    , { text = "index", x = 464, y = 2322, height = 15, width = 28 }
    , { text = "AS", x = 535, y = 2353, height = 18, width = 18 }
    , { text = "IF", x = 557, y = 2353, height = 18, width = 15 }
    , { text = "plume", x = 51, y = 2387, height = 15, width = 32 }
    , { text = "solitary", x = 86, y = 2387, height = 15, width = 40 }
    , { text = "distraught", x = 129, y = 2387, height = 15, width = 53 }
    , { text = "save", x = 214, y = 2486, height = 15, width = 23 }
    , { text = "that", x = 240, y = 2486, height = 15, width = 20 }
    , { text = "encounters", x = 264, y = 2486, height = 15, width = 57 }
    , { text = "or", x = 324, y = 2486, height = 15, width = 11 }
    , { text = "skims", x = 339, y = 2486, height = 15, width = 29 }
    , { text = "it", x = 371, y = 2486, height = 15, width = 7 }
    , { text = "a", x = 381, y = 2486, height = 15, width = 7 }
    , { text = "midnight", x = 391, y = 2486, height = 15, width = 46 }
    , { text = "cap", x = 441, y = 2486, height = 15, width = 18 }
    , { text = "and", x = 369, y = 2501, height = 15, width = 20 }
    , { text = "immobilizes", x = 392, y = 2501, height = 15, width = 62 }
    , { text = "in", x = 286, y = 2516, height = 15, width = 10 }
    , { text = "velvet", x = 299, y = 2516, height = 15, width = 30 }
    , { text = "crumpled", x = 333, y = 2516, height = 15, width = 49 }
    , { text = "by", x = 385, y = 2516, height = 15, width = 12 }
    , { text = "a", x = 401, y = 2516, height = 15, width = 6 }
    , { text = "guffaw", x = 410, y = 2516, height = 15, width = 36 }
    , { text = "somber", x = 449, y = 2516, height = 15, width = 38 }
    , { text = "that", x = 369, y = 2547, height = 15, width = 21 }
    , { text = "rigid", x = 393, y = 2547, height = 15, width = 25 }
    , { text = "whiteness", x = 421, y = 2547, height = 15, width = 51 }
    , { text = "derisory", x = 201, y = 2578, height = 15, width = 43 }
    , { text = "in", x = 411, y = 2609, height = 15, width = 10 }
    , { text = "opposition", x = 425, y = 2609, height = 15, width = 55 }
    , { text = "to", x = 483, y = 2609, height = 15, width = 10 }
    , { text = "the", x = 496, y = 2609, height = 15, width = 16 }
    , { text = "sky", x = 515, y = 2609, height = 15, width = 17 }
    , { text = "too", x = 274, y = 2640, height = 15, width = 17 }
    , { text = "much", x = 294, y = 2640, height = 15, width = 28 }
    , { text = "for", x = 390, y = 2655, height = 15, width = 16 }
    , { text = "not", x = 409, y = 2655, height = 15, width = 16 }
    , { text = "marking", x = 429, y = 2655, height = 15, width = 43 }
    , { text = "exiguously", x = 441, y = 2670, height = 15, width = 56 }
    , { text = "whosoever", x = 466, y = 2685, height = 15, width = 56 }
    , { text = "bitter", x = 372, y = 2716, height = 15, width = 28 }
    , { text = "prince", x = 403, y = 2716, height = 15, width = 33 }
    , { text = "of", x = 440, y = 2716, height = 15, width = 10 }
    , { text = "the", x = 453, y = 2716, height = 15, width = 16 }
    , { text = "reef", x = 472, y = 2716, height = 15, width = 20 }
    , { text = "puts", x = 421, y = 2747, height = 15, width = 22 }
    , { text = "it", x = 446, y = 2747, height = 15, width = 8 }
    , { text = "on", x = 457, y = 2747, height = 15, width = 13 }
    , { text = "like", x = 473, y = 2747, height = 15, width = 19 }
    , { text = "the", x = 495, y = 2747, height = 15, width = 16 }
    , { text = "heroic", x = 514, y = 2747, height = 15, width = 33 }
    , { text = "irresistible", x = 407, y = 2762, height = 15, width = 56 }
    , { text = "but", x = 466, y = 2762, height = 15, width = 16 }
    , { text = "contained", x = 486, y = 2762, height = 15, width = 51 }
    , { text = "by", x = 400, y = 2777, height = 15, width = 13 }
    , { text = "his", x = 416, y = 2777, height = 15, width = 15 }
    , { text = "little", x = 434, y = 2777, height = 15, width = 24 }
    , { text = "reason", x = 461, y = 2777, height = 15, width = 35 }
    , { text = "virile", x = 500, y = 2777, height = 15, width = 27 }
    , { text = "in", x = 512, y = 2792, height = 15, width = 10 }
    , { text = "lightning", x = 525, y = 2792, height = 15, width = 47 }
    , { text = "concerned", x = 1, y = 2823, height = 15, width = 54 }
    , { text = "expiatory", x = 76, y = 2838, height = 15, width = 49 }
    , { text = "and", x = 128, y = 2838, height = 15, width = 20 }
    , { text = "pubescent", x = 151, y = 2838, height = 15, width = 52 }
    , { text = "mute", x = 251, y = 2853, height = 15, width = 25 }
    , { text = "laughter", x = 351, y = 2853, height = 15, width = 44 }
    , { text = "that", x = 432, y = 2884, height = 15, width = 20 }
    , { text = "IF", x = 477, y = 2915, height = 18, width = 15 }
    , { text = "The", x = 73, y = 2964, height = 15, width = 19 }
    , { text = "lucid", x = 95, y = 2964, height = 15, width = 26 }
    , { text = "and", x = 125, y = 2964, height = 15, width = 19 }
    , { text = "seigniorial", x = 147, y = 2964, height = 15, width = 57 }
    , { text = "aigrette", x = 207, y = 2964, height = 15, width = 40 }
    , { text = "of", x = 250, y = 2964, height = 15, width = 10 }
    , { text = "vertigo", x = 264, y = 2964, height = 15, width = 36 }
    , { text = "with", x = 112, y = 2979, height = 15, width = 22 }
    , { text = "invisible", x = 138, y = 2979, height = 15, width = 44 }
    , { text = "brow", x = 185, y = 2979, height = 15, width = 26 }
    , { text = "scintillates", x = 96, y = 2994, height = 15, width = 56 }
    , { text = "then", x = 151, y = 3009, height = 15, width = 23 }
    , { text = "shadows", x = 177, y = 3009, height = 15, width = 45 }

    --, { text = "a" , x = 130 , y = 3024 , height = 15 , width = 6
    --  } , { text = "stature" , x = 139 , y = 3024 , height = 15 , width = 36 }
    , { text = "dainty", x = 178, y = 3024, height = 15, width = 33 }
    , { text = "tenebrous", x = 214, y = 3024, height = 15, width = 51 }
    , { text = "erect", x = 268, y = 3024, height = 15, width = 25 }
    , { text = "in", x = 138, y = 3039, height = 15, width = 10 }
    , { text = "its", x = 151, y = 3039, height = 15, width = 12 }
    , { text = "siren", x = 167, y = 3039, height = 15, width = 25 }
    , { text = "torsion", x = 195, y = 3039, height = 15, width = 37 }
    , { text = "time", x = 313, y = 3054, height = 15, width = 22 }
    , { text = "to", x = 319, y = 3069, height = 15, width = 10 }
    , { text = "slap", x = 332, y = 3069, height = 15, width = 22 }
    , { text = "with", x = 106, y = 3084, height = 15, width = 22 }
    , { text = "impatient", x = 131, y = 3084, height = 15, width = 49 }
    , { text = "scales", x = 184, y = 3084, height = 15, width = 31 }
    , { text = "ultimate", x = 219, y = 3084, height = 15, width = 42 }
    , { text = "bifurcated", x = 264, y = 3084, height = 15, width = 53 }
    , { text = "a", x = 380, y = 3115, height = 15, width = 6 }
    , { text = "rock", x = 389, y = 3115, height = 15, width = 23 }
    , { text = "false", x = 320, y = 3146, height = 15, width = 25 }
    , { text = "manor", x = 348, y = 3146, height = 15, width = 34 }
    , { text = "right", x = 351, y = 3161, height = 15, width = 25 }
    , { text = "away", x = 380, y = 3161, height = 15, width = 27 }
    , { text = "evaporated", x = 395, y = 3176, height = 15, width = 59 }
    , { text = "in", x = 457, y = 3176, height = 15, width = 10 }
    , { text = "mists", x = 470, y = 3176, height = 15, width = 27 }
    , { text = "that", x = 390, y = 3207, height = 15, width = 20 }
    , { text = "imposed", x = 414, y = 3207, height = 15, width = 43 }
    , { text = "a", x = 443, y = 3222, height = 15, width = 6 }
    , { text = "limit", x = 453, y = 3222, height = 15, width = 23 }
    , { text = "on", x = 480, y = 3222, height = 15, width = 13 }
    , { text = "infinity", x = 496, y = 3222, height = 15, width = 36 }
    , { text = "IT", x = 138, y = 3253, height = 18, width = 14 }
    , { text = "WAS", x = 155, y = 3253, height = 18, width = 30 }
    , { text = "stellar", x = 135, y = 3273, height = 15, width = 34 }
    , { text = "issue", x = 172, y = 3273, height = 15, width = 26 }
    , { text = "NUMBER", x = 373, y = 3271, height = 18, width = 65 }
    , { text = "EXISTED", x = 365, y = 3305, height = 18, width = 67 }
    , { text = "HE", x = 436, y = 3305, height = 18, width = 21 }
    , { text = "otherwise", x = 343, y = 3323, height = 13, width = 39 }
    , { text = "than", x = 384, y = 3323, height = 13, width = 17 }
    , { text = "scattered", x = 404, y = 3323, height = 13, width = 35 }
    , { text = "hallucination", x = 442, y = 3323, height = 13, width = 52 }
    , { text = "of", x = 497, y = 3323, height = 13, width = 8 }
    , { text = "agony", x = 508, y = 3323, height = 13, width = 24 }
    , { text = "COMMENCED", x = 273, y = 3352, height = 18, width = 104 }
    , { text = "HE", x = 381, y = 3352, height = 18, width = 22 }
    , { text = "AND", x = 406, y = 3352, height = 18, width = 34 }
    , { text = "CEASED", x = 444, y = 3352, height = 18, width = 63 }
    , { text = "HE", x = 511, y = 3352, height = 18, width = 21 }
    , { text = "upwelling", x = 316, y = 3370, height = 13, width = 40 }
    , { text = "but", x = 359, y = 3370, height = 13, width = 13 }
    , { text = "denied", x = 374, y = 3370, height = 13, width = 27 }
    , { text = "and", x = 403, y = 3370, height = 13, width = 15 }
    , { text = "closed", x = 420, y = 3370, height = 13, width = 26 }
    , { text = "when", x = 448, y = 3370, height = 13, width = 22 }
    , { text = "apparent", x = 473, y = 3370, height = 13, width = 34 }
    , { text = "at", x = 333, y = 3383, height = 13, width = 8 }
    , { text = "last", x = 343, y = 3383, height = 13, width = 14 }
    , { text = "by", x = 325, y = 3396, height = 13, width = 10 }
    , { text = "some", x = 338, y = 3396, height = 13, width = 21 }
    , { text = "profusion", x = 361, y = 3396, height = 13, width = 39 }
    , { text = "widespread", x = 402, y = 3396, height = 13, width = 46 }
    , { text = "in", x = 450, y = 3396, height = 13, width = 8 }
    , { text = "rarity", x = 460, y = 3396, height = 13, width = 22 }
    , { text = "CIPHERED", x = 363, y = 3409, height = 18, width = 79 }
    , { text = "HE", x = 446, y = 3409, height = 18, width = 21 }
    , { text = "evidence", x = 306, y = 3447, height = 13, width = 35 }
    , { text = "of", x = 344, y = 3447, height = 13, width = 8 }
    , { text = "the", x = 355, y = 3447, height = 13, width = 12 }
    , { text = "sum", x = 369, y = 3447, height = 13, width = 17 }
    , { text = "if", x = 389, y = 3447, height = 13, width = 6 }
    , { text = "only", x = 397, y = 3447, height = 13, width = 18 }
    , { text = "one", x = 418, y = 3447, height = 13, width = 14 }
    , { text = "ILLUMINATED", x = 373, y = 3461, height = 18, width = 109 }
    , { text = "HE", x = 486, y = 3461, height = 18, width = 21 }
    , { text = "IT", x = 1, y = 3495, height = 18, width = 14 }
    , { text = "WOULD", x = 19, y = 3495, height = 18, width = 57 }
    , { text = "BE", x = 80, y = 3495, height = 18, width = 19 }
    , { text = "worse", x = 51, y = 3513, height = 13, width = 24 }
    , { text = "no", x = 126, y = 3526, height = 13, width = 10 }
    , { text = "more", x = 151, y = 3539, height = 13, width = 20 }
    , { text = "nor", x = 174, y = 3539, height = 13, width = 14 }
    , { text = "less", x = 190, y = 3539, height = 13, width = 15 }
    , { text = "indifferently", x = 101, y = 3564, height = 13, width = 49 }
    , { text = "but", x = 152, y = 3564, height = 13, width = 13 }
    , { text = "as", x = 167, y = 3564, height = 13, width = 9 }
    , { text = "much", x = 179, y = 3564, height = 13, width = 21 }
    , { text = "CHANCE", x = 275, y = 3552, height = 28, width = 99 }
    , { text = "Falls", x = 230, y = 3630, height = 15, width = 27 }
    , { text = "the", x = 261, y = 3645, height = 15, width = 16 }
    , { text = "plume", x = 280, y = 3645, height = 15, width = 32 }
    , { text = "rhythmic", x = 322, y = 3660, height = 15, width = 46 }
    , { text = "suspense", x = 372, y = 3660, height = 15, width = 46 }
    , { text = "of", x = 421, y = 3660, height = 15, width = 10 }
    , { text = "the", x = 435, y = 3660, height = 15, width = 15 }
    , { text = "sinister", x = 454, y = 3660, height = 15, width = 38 }
    , { text = "to", x = 481, y = 3675, height = 15, width = 10 }
    , { text = "bury", x = 495, y = 3675, height = 15, width = 23 }
    , { text = "itself", x = 522, y = 3675, height = 15, width = 25 }
    , { text = "in", x = 467, y = 3690, height = 15, width = 11 }
    , { text = "original", x = 481, y = 3690, height = 15, width = 42 }
    , { text = "foams", x = 526, y = 3690, height = 15, width = 31 }
    , { text = "not", x = 275, y = 3705, height = 15, width = 16 }
    , { text = "long", x = 294, y = 3705, height = 15, width = 24 }
    , { text = "ago", x = 321, y = 3705, height = 15, width = 19 }
    , { text = "whence", x = 344, y = 3705, height = 15, width = 39 }
    , { text = "sprang", x = 386, y = 3705, height = 15, width = 36 }
    , { text = "up", x = 425, y = 3705, height = 15, width = 13 }
    , { text = "its", x = 441, y = 3705, height = 15, width = 13 }
    , { text = "delirium", x = 457, y = 3705, height = 15, width = 44 }
    , { text = "to", x = 504, y = 3705, height = 15, width = 10 }
    , { text = "a", x = 518, y = 3705, height = 15, width = 6 }
    , { text = "peak", x = 527, y = 3705, height = 15, width = 25 }
    , { text = "withered", x = 467, y = 3720, height = 15, width = 45 }
    , { text = "by", x = 342, y = 3735, height = 15, width = 12 }
    , { text = "the", x = 358, y = 3735, height = 15, width = 15 }
    , { text = "identical", x = 377, y = 3735, height = 15, width = 45 }
    , { text = "neutrality", x = 425, y = 3735, height = 15, width = 51 }
    , { text = "of", x = 479, y = 3735, height = 15, width = 10 }
    , { text = "the", x = 493, y = 3735, height = 15, width = 16 }
    , { text = "gulf", x = 512, y = 3735, height = 15, width = 20 }
    , { text = "NOTHING", x = 1, y = 4072, height = 18, width = 73 }
    , { text = "of", x = 101, y = 4140, height = 15, width = 11 }
    , { text = "the", x = 115, y = 4140, height = 15, width = 16 }
    , { text = "memorable", x = 134, y = 4140, height = 15, width = 59 }
    , { text = "crisis", x = 196, y = 4140, height = 15, width = 27 }
    , { text = "when", x = 151, y = 4155, height = 15, width = 28 }
    , { text = "might", x = 182, y = 4155, height = 15, width = 31 }
    , { text = "the", x = 176, y = 4170, height = 15, width = 16 }
    , { text = "event", x = 195, y = 4170, height = 15, width = 28 }
    , { text = "have", x = 227, y = 4170, height = 15, width = 24 }
    , { text = "been", x = 254, y = 4170, height = 15, width = 25 }
    , { text = "accomplished", x = 282, y = 4170, height = 15, width = 72 }
    , { text = "in", x = 357, y = 4170, height = 15, width = 10 }
    , { text = "view", x = 370, y = 4170, height = 15, width = 26 }
    , { text = "of", x = 399, y = 4170, height = 15, width = 11 }
    , { text = "every", x = 413, y = 4170, height = 15, width = 29 }
    , { text = "result", x = 445, y = 4170, height = 15, width = 29 }
    , { text = "null", x = 477, y = 4170, height = 15, width = 20 }
    , { text = "human", x = 526, y = 4185, height = 15, width = 35 }
    , { text = "WILL", x = 335, y = 4216, height = 18, width = 40 }
    , { text = "HAVE", x = 378, y = 4216, height = 18, width = 43 }
    , { text = "TAKEN", x = 425, y = 4216, height = 18, width = 52 }
    , { text = "PLACE", x = 481, y = 4216, height = 18, width = 51 }
    , { text = "an", x = 345, y = 4234, height = 15, width = 12 }
    , { text = "ordinary", x = 361, y = 4234, height = 15, width = 44 }
    , { text = "elevation", x = 408, y = 4234, height = 15, width = 47 }
    , { text = "pours", x = 459, y = 4234, height = 15, width = 29 }
    , { text = "absence", x = 491, y = 4234, height = 15, width = 41 }
    , { text = "BUT", x = 426, y = 4265, height = 18, width = 32 }
    , { text = "THE", x = 461, y = 4265, height = 18, width = 31 }
    , { text = "PLACE", x = 496, y = 4265, height = 18, width = 51 }
    , { text = "inferior", x = 280, y = 4283, height = 15, width = 39 }
    , { text = "lapping", x = 322, y = 4283, height = 15, width = 39 }
    , { text = "whatsoever", x = 364, y = 4283, height = 15, width = 60 }
    , { text = "as", x = 427, y = 4283, height = 15, width = 11 }
    , { text = "if", x = 441, y = 4283, height = 15, width = 8 }
    , { text = "to", x = 452, y = 4283, height = 15, width = 10 }
    , { text = "disperse", x = 465, y = 4283, height = 15, width = 43 }
    , { text = "the", x = 511, y = 4283, height = 15, width = 16 }
    , { text = "act", x = 530, y = 4283, height = 15, width = 16 }
    , { text = "void", x = 549, y = 4283, height = 15, width = 23 }
    , { text = "abruptly", x = 363, y = 4298, height = 15, width = 43 }
    , { text = "which", x = 409, y = 4298, height = 15, width = 32 }
    , { text = "if", x = 444, y = 4298, height = 15, width = 8 }
    , { text = "not", x = 455, y = 4298, height = 15, width = 17 }
    , { text = "by", x = 340, y = 4313, height = 15, width = 13 }
    , { text = "its", x = 356, y = 4313, height = 15, width = 12 }
    , { text = "falsehood", x = 371, y = 4313, height = 15, width = 51 }
    , { text = "might", x = 318, y = 4328, height = 15, width = 30 }
    , { text = "have", x = 352, y = 4328, height = 15, width = 24 }
    , { text = "founded", x = 379, y = 4328, height = 15, width = 43 }
    , { text = "perdition", x = 375, y = 4343, height = 15, width = 47 }
    , { text = "in", x = 215, y = 4374, height = 15, width = 10 }
    , { text = "those", x = 228, y = 4374, height = 15, width = 27 }
    , { text = "regions", x = 259, y = 4374, height = 15, width = 38 }
    , { text = "of", x = 326, y = 4389, height = 15, width = 11 }
    , { text = "the", x = 340, y = 4389, height = 15, width = 16 }
    , { text = "wave", x = 360, y = 4389, height = 15, width = 27 }
    , { text = "in", x = 423, y = 4404, height = 15, width = 10 }
    , { text = "which", x = 437, y = 4404, height = 15, width = 31 }
    , { text = "all", x = 472, y = 4404, height = 15, width = 13 }
    , { text = "reality", x = 488, y = 4404, height = 15, width = 33 }
    , { text = "dissolves", x = 524, y = 4404, height = 15, width = 48 }
    , { text = "EXCEPT", x = 1, y = 4435, height = 18, width = 60 }
    , { text = "at", x = 51, y = 4455, height = 15, width = 9 }
    , { text = "the", x = 64, y = 4455, height = 15, width = 16 }
    , { text = "altitude", x = 83, y = 4455, height = 15, width = 39 }
    , { text = "PERHAPS", x = 126, y = 4471, height = 18, width = 70 }
    , { text = "as", x = 176, y = 4489, height = 15, width = 11 }
    , { text = "far", x = 190, y = 4489, height = 15, width = 15 }
    , { text = "as", x = 208, y = 4489, height = 15, width = 11 }
    , { text = "a", x = 222, y = 4489, height = 15, width = 6 }
    , { text = "place", x = 231, y = 4489, height = 15, width = 27 }
    , { text = "fuses", x = 262, y = 4489, height = 15, width = 26 }
    , { text = "with", x = 292, y = 4489, height = 15, width = 23 }
    , { text = "beyond", x = 318, y = 4489, height = 15, width = 38 }
    , { text = "apart", x = 357, y = 4520, height = 15, width = 26 }
    , { text = "from", x = 386, y = 4520, height = 15, width = 25 }
    , { text = "the", x = 415, y = 4520, height = 15, width = 15 }
    , { text = "interest", x = 434, y = 4520, height = 15, width = 38 }
    , { text = "as", x = 316, y = 4535, height = 15, width = 11 }
    , { text = "to", x = 330, y = 4535, height = 15, width = 10 }
    , { text = "it", x = 343, y = 4535, height = 15, width = 7 }
    , { text = "signaled", x = 354, y = 4535, height = 15, width = 43 }
    , { text = "in", x = 505, y = 4550, height = 15, width = 10 }
    , { text = "general", x = 519, y = 4550, height = 15, width = 38 }
    , { text = "according", x = 263, y = 4565, height = 15, width = 51 }
    , { text = "to", x = 317, y = 4565, height = 15, width = 11 }
    , { text = "such", x = 331, y = 4565, height = 15, width = 24 }
    , { text = "obliquity", x = 358, y = 4565, height = 15, width = 47 }
    , { text = "by", x = 408, y = 4565, height = 15, width = 13 }
    , { text = "such", x = 424, y = 4565, height = 15, width = 24 }
    , { text = "declivity", x = 452, y = 4565, height = 15, width = 45 }
    , { text = "of", x = 511, y = 4580, height = 15, width = 10 }
    , { text = "fires", x = 525, y = 4580, height = 15, width = 22 }
    , { text = "toward", x = 286, y = 4595, height = 15, width = 36 }
    , { text = "this", x = 309, y = 4626, height = 15, width = 19 }
    , { text = "must", x = 331, y = 4626, height = 15, width = 25 }
    , { text = "be", x = 360, y = 4626, height = 15, width = 12 }
    , { text = "the", x = 335, y = 4641, height = 15, width = 16 }
    , { text = "Septentrion", x = 354, y = 4641, height = 15, width = 60 }
    , { text = "also", x = 417, y = 4641, height = 15, width = 21 }
    , { text = "North", x = 442, y = 4641, height = 15, width = 30 }
    , { text = "A", x = 428, y = 4672, height = 18, width = 11 }
    , { text = "CONSTELLATION", x = 442, y = 4672, height = 18, width = 130 }
    , { text = "cold", x = 328, y = 4706, height = 15, width = 22 }
    , { text = "from", x = 353, y = 4706, height = 15, width = 25 }
    , { text = "forgetting", x = 382, y = 4706, height = 15, width = 51 }
    , { text = "and", x = 436, y = 4706, height = 15, width = 19 }
    , { text = "desuetude", x = 458, y = 4706, height = 15, width = 52 }
    , { text = "not", x = 446, y = 4721, height = 15, width = 17 }
    , { text = "so", x = 466, y = 4721, height = 15, width = 12 }
    , { text = "much", x = 481, y = 4721, height = 15, width = 29 }
    , { text = "that", x = 398, y = 4736, height = 15, width = 19 }
    , { text = "it", x = 420, y = 4736, height = 15, width = 8 }
    , { text = "does", x = 431, y = 4736, height = 15, width = 24 }
    , { text = "not", x = 458, y = 4736, height = 15, width = 17 }
    , { text = "enumerate", x = 478, y = 4736, height = 15, width = 54 }
    , { text = "on", x = 382, y = 4751, height = 15, width = 13 }
    , { text = "some", x = 399, y = 4751, height = 15, width = 27 }
    , { text = "surface", x = 429, y = 4751, height = 15, width = 38 }
    , { text = "vacant", x = 470, y = 4751, height = 15, width = 34 }
    , { text = "and", x = 507, y = 4751, height = 15, width = 19 }
    , { text = "superior", x = 529, y = 4751, height = 15, width = 43 }
    , { text = "the", x = 398, y = 4766, height = 15, width = 16 }
    , { text = "successive", x = 417, y = 4766, height = 15, width = 55 }
    , { text = "clash", x = 475, y = 4766, height = 15, width = 27 }
    , { text = "sidereally", x = 471, y = 4781, height = 15, width = 51 }
    , { text = "of", x = 366, y = 4796, height = 15, width = 11 }
    , { text = "a", x = 380, y = 4796, height = 15, width = 6 }
    , { text = "total", x = 389, y = 4796, height = 15, width = 23 }
    , { text = "count", x = 415, y = 4796, height = 15, width = 29 }
    , { text = "in", x = 447, y = 4796, height = 15, width = 10 }
    , { text = "formation", x = 461, y = 4796, height = 15, width = 51 }
    , { text = "watching", x = 249, y = 4811, height = 15, width = 48 }
    , { text = "doubting", x = 311, y = 4826, height = 15, width = 46 }
    , { text = "rolling", x = 367, y = 4841, height = 15, width = 35 }
    , { text = "shining", x = 418, y = 4856, height = 15, width = 38 }
    , { text = "and", x = 459, y = 4856, height = 15, width = 19 }
    , { text = "meditating", x = 481, y = 4856, height = 15, width = 56 }
    , { text = "before", x = 476, y = 4887, height = 15, width = 33 }
    , { text = "stopping", x = 512, y = 4887, height = 15, width = 45 }
    , { text = "at", x = 384, y = 4902, height = 15, width = 10 }
    , { text = "some", x = 397, y = 4902, height = 15, width = 27 }
    , { text = "last", x = 428, y = 4902, height = 15, width = 18 }
    , { text = "point", x = 449, y = 4902, height = 15, width = 27 }
    , { text = "that", x = 479, y = 4902, height = 15, width = 19 }
    , { text = "consecrates", x = 502, y = 4902, height = 15, width = 60 }
    , { text = "it", x = 565, y = 4902, height = 15, width = 7 }
    , { text = "Every", x = 323, y = 4933, height = 15, width = 31 }
    , { text = "Thought", x = 358, y = 4933, height = 15, width = 44 }
    , { text = "sends", x = 405, y = 4933, height = 15, width = 29 }
    , { text = "forth", x = 437, y = 4933, height = 15, width = 25 }
    , { text = "one", x = 466, y = 4933, height = 15, width = 18 }
    , { text = "Toss", x = 487, y = 4933, height = 15, width = 24 }
    , { text = "of", x = 514, y = 4933, height = 15, width = 11 }
    , { text = "the", x = 528, y = 4933, height = 15, width = 16 }
    , { text = "Dice", x = 547, y = 4933, height = 15, width = 25 }
    ]


pages =
    [ [ { height = 28, text = "ONE", width = 49, x = 41, y = 69 }, { height = 28, text = "TOSS", width = 58, x = 96, y = 69 }, { height = 28, text = "OF", width = 31, x = 160, y = 69 }, { height = 28, text = "THE", width = 46, x = 197, y = 69 }, { height = 28, text = "DICE", width = 56, x = 249, y = 69 }, { height = 28, text = "NEVER", width = 80, x = 412, y = 113 }, { height = 15, text = "NOT", width = 26, x = 350, y = 157 }, { height = 15, text = "EVEN", width = 34, x = 380, y = 157 }, { height = 15, text = "WHEN", width = 39, x = 417, y = 157 }, { height = 15, text = "CAST", width = 33, x = 460, y = 157 }, { height = 15, text = "IN", width = 14, x = 496, y = 157 }, { height = 15, text = "ETERNAL", width = 59, x = 513, y = 157 }, { height = 15, text = "CIRCUMSTANCES", width = 108, x = 319, y = 172 }, { height = 15, text = "FROM", width = 37, x = 345, y = 203 }, { height = 15, text = "THE", width = 25, x = 385, y = 203 }, { height = 15, text = "DEPTHS", width = 50, x = 413, y = 203 }, { height = 15, text = "OF", width = 16, x = 466, y = 203 }, { height = 15, text = "A", width = 9, x = 485, y = 203 }, { height = 15, text = "SHIPWRECK", width = 75, x = 497, y = 203 } ]
    , [ { height = 18, text = "WHETHER", width = 78, x = 1, y = 0 }, { height = 15, text = "the", width = 16, x = 51, y = 18 }, { height = 15, text = "Abyss", width = 33, x = 81, y = 83 }, { height = 15, text = "whitened", width = 48, x = 1, y = 148 }, { height = 15, text = "becalmed", width = 50, x = 41, y = 179 }, { height = 15, text = "furious", width = 37, x = 81, y = 210 }, { height = 15, text = "under", width = 30, x = 121, y = 241 }, { height = 15, text = "an", width = 12, x = 154, y = 241 }, { height = 15, text = "inclination", width = 56, x = 169, y = 241 }, { height = 15, text = "glides", width = 31, x = 131, y = 256 }, { height = 15, text = "desperately", width = 59, x = 165, y = 256 }, { height = 15, text = "with", width = 23, x = 161, y = 321 }, { height = 15, text = "wing", width = 26, x = 187, y = 321 }, { height = 15, text = "its", width = 12, x = 144, y = 352 }, { height = 15, text = "own", width = 22, x = 160, y = 352 }, { height = 15, text = "in", width = 11, x = 248, y = 367 }, { height = 15, text = "advance", width = 42, x = 262, y = 367 }, { height = 15, text = "refallen", width = 39, x = 308, y = 367 }, { height = 15, text = "with", width = 23, x = 351, y = 367 }, { height = 15, text = "a", width = 6, x = 377, y = 367 }, { height = 15, text = "difficulty", width = 48, x = 386, y = 367 }, { height = 15, text = "in", width = 10, x = 437, y = 367 }, { height = 15, text = "setting", width = 35, x = 450, y = 367 }, { height = 15, text = "up", width = 13, x = 488, y = 367 }, { height = 15, text = "flight", width = 27, x = 505, y = 367 }, { height = 15, text = "and", width = 19, x = 380, y = 382 }, { height = 15, text = "covering", width = 45, x = 402, y = 382 }, { height = 15, text = "the", width = 16, x = 451, y = 382 }, { height = 15, text = "outpourings", width = 62, x = 470, y = 382 }, { height = 15, text = "cutting", width = 36, x = 410, y = 397 }, { height = 15, text = "utterly", width = 34, x = 449, y = 397 }, { height = 15, text = "the", width = 16, x = 486, y = 397 }, { height = 15, text = "leaps", width = 27, x = 505, y = 397 }, { height = 15, text = "very", width = 24, x = 331, y = 428 }, { height = 15, text = "interiorly", width = 48, x = 358, y = 428 }, { height = 15, text = "resumes", width = 43, x = 409, y = 428 }, { height = 15, text = "the", width = 16, x = 308, y = 459 }, { height = 15, text = "shade", width = 30, x = 327, y = 459 }, { height = 15, text = "buried", width = 33, x = 360, y = 459 }, { height = 15, text = "in", width = 10, x = 397, y = 459 }, { height = 15, text = "the", width = 16, x = 410, y = 459 }, { height = 15, text = "deep", width = 25, x = 429, y = 459 }, { height = 15, text = "by", width = 13, x = 457, y = 459 }, { height = 15, text = "that", width = 20, x = 473, y = 459 }, { height = 15, text = "alternative", width = 55, x = 496, y = 459 }, { height = 15, text = "sail", width = 18, x = 554, y = 459 }, { height = 15, text = "as", width = 11, x = 457, y = 490 }, { height = 15, text = "to", width = 10, x = 471, y = 490 }, { height = 15, text = "adapt", width = 29, x = 484, y = 490 }, { height = 15, text = "to", width = 10, x = 453, y = 505 }, { height = 15, text = "its", width = 12, x = 467, y = 505 }, { height = 15, text = "wingspan", width = 50, x = 482, y = 505 }, { height = 15, text = "its", width = 13, x = 352, y = 536 }, { height = 15, text = "gaping", width = 35, x = 368, y = 536 }, { height = 15, text = "depth", width = 29, x = 406, y = 536 }, { height = 15, text = "as", width = 10, x = 439, y = 536 }, { height = 15, text = "the", width = 16, x = 453, y = 536 }, { height = 15, text = "hull", width = 20, x = 472, y = 536 }, { height = 15, text = "of", width = 11, x = 437, y = 567 }, { height = 15, text = "a", width = 6, x = 451, y = 567 }, { height = 15, text = "vessel", width = 32, x = 460, y = 567 }, { height = 15, text = "tilted", width = 27, x = 382, y = 598 }, { height = 15, text = "to", width = 11, x = 412, y = 598 }, { height = 15, text = "one", width = 19, x = 426, y = 598 }, { height = 15, text = "or", width = 11, x = 448, y = 598 }, { height = 15, text = "the", width = 16, x = 462, y = 598 }, { height = 15, text = "other", width = 27, x = 481, y = 598 }, { height = 15, text = "side", width = 21, x = 511, y = 598 } ]
    , [ { height = 18, text = "THE", width = 31, x = 91, y = 0 }, { height = 18, text = "MASTER", width = 65, x = 126, y = 0 }, { height = 15, text = "outside", width = 38, x = 341, y = 2 }, { height = 15, text = "old", width = 16, x = 382, y = 2 }, { height = 15, text = "calculations", width = 62, x = 402, y = 2 }, { height = 15, text = "where", width = 32, x = 291, y = 18 }, { height = 15, text = "the", width = 16, x = 326, y = 18 }, { height = 15, text = "maneuver", width = 51, x = 345, y = 18 }, { height = 15, text = "with", width = 23, x = 400, y = 18 }, { height = 15, text = "age", width = 18, x = 426, y = 18 }, { height = 15, text = "forgotten", width = 48, x = 447, y = 18 }, { height = 15, text = "arisen", width = 31, x = 41, y = 49 }, { height = 15, text = "inferring", width = 45, x = 51, y = 64 }, { height = 15, text = "long", width = 23, x = 346, y = 64 }, { height = 15, text = "ago", width = 18, x = 373, y = 64 }, { height = 15, text = "he", width = 12, x = 395, y = 64 }, { height = 15, text = "grasped", width = 41, x = 410, y = 64 }, { height = 15, text = "the", width = 16, x = 454, y = 64 }, { height = 15, text = "helm", width = 26, x = 473, y = 64 }, { height = 15, text = "of", width = 11, x = 121, y = 95 }, { height = 15, text = "that", width = 20, x = 135, y = 95 }, { height = 15, text = "conflagration", width = 68, x = 158, y = 95 }, { height = 15, text = "at", width = 9, x = 230, y = 95 }, { height = 15, text = "his", width = 16, x = 242, y = 95 }, { height = 15, text = "feet", width = 19, x = 261, y = 95 }, { height = 15, text = "of", width = 11, x = 271, y = 110 }, { height = 15, text = "the", width = 16, x = 285, y = 110 }, { height = 15, text = "unanimous", width = 57, x = 304, y = 110 }, { height = 15, text = "horizon", width = 39, x = 365, y = 110 }, { height = 15, text = "there", width = 26, x = 231, y = 141 }, { height = 15, text = "is", width = 9, x = 260, y = 141 }, { height = 15, text = "preparing", width = 50, x = 272, y = 141 }, { height = 15, text = "stirring", width = 38, x = 281, y = 156 }, { height = 15, text = "and", width = 19, x = 322, y = 156 }, { height = 15, text = "mixing", width = 37, x = 344, y = 156 }, { height = 15, text = "in", width = 10, x = 306, y = 171 }, { height = 15, text = "the", width = 16, x = 319, y = 171 }, { height = 15, text = "fist", width = 15, x = 339, y = 171 }, { height = 15, text = "that", width = 19, x = 358, y = 171 }, { height = 15, text = "might", width = 31, x = 380, y = 171 }, { height = 15, text = "clutch", width = 32, x = 414, y = 171 }, { height = 15, text = "it", width = 7, x = 449, y = 171 }, { height = 15, text = "as", width = 11, x = 156, y = 186 }, { height = 15, text = "one", width = 19, x = 170, y = 186 }, { height = 15, text = "menaces", width = 45, x = 192, y = 186 }, { height = 15, text = "a", width = 6, x = 240, y = 186 }, { height = 15, text = "destiny", width = 38, x = 249, y = 186 }, { height = 15, text = "and", width = 19, x = 290, y = 186 }, { height = 15, text = "the", width = 16, x = 312, y = 186 }, { height = 15, text = "winds", width = 31, x = 331, y = 186 }, { height = 15, text = "the", width = 16, x = 51, y = 217 }, { height = 15, text = "unique", width = 35, x = 70, y = 217 }, { height = 15, text = "Number", width = 42, x = 109, y = 217 }, { height = 15, text = "which", width = 32, x = 154, y = 217 }, { height = 15, text = "cannot", width = 35, x = 189, y = 217 }, { height = 15, text = "be", width = 13, x = 227, y = 217 }, { height = 15, text = "another", width = 39, x = 243, y = 217 }, { height = 15, text = "Spirit", width = 29, x = 322, y = 248 }, { height = 15, text = "to", width = 10, x = 364, y = 263 }, { height = 15, text = "hurl", width = 21, x = 377, y = 263 }, { height = 15, text = "it", width = 7, x = 402, y = 263 }, { height = 15, text = "in", width = 10, x = 413, y = 278 }, { height = 15, text = "the", width = 16, x = 426, y = 278 }, { height = 15, text = "tempest", width = 40, x = 445, y = 278 }, { height = 15, text = "refolding", width = 48, x = 319, y = 293 }, { height = 15, text = "the", width = 16, x = 370, y = 293 }, { height = 15, text = "division", width = 42, x = 389, y = 293 }, { height = 15, text = "and", width = 19, x = 434, y = 293 }, { height = 15, text = "passing", width = 39, x = 456, y = 293 }, { height = 15, text = "proud", width = 30, x = 499, y = 293 }, { height = 15, text = "hesitates", width = 44, x = 202, y = 308 }, { height = 15, text = "a", width = 6, x = 150, y = 323 }, { height = 15, text = "corpse", width = 34, x = 159, y = 323 }, { height = 15, text = "by", width = 13, x = 196, y = 323 }, { height = 15, text = "the", width = 16, x = 212, y = 323 }, { height = 15, text = "arm", width = 21, x = 231, y = 323 }, { height = 15, text = "set", width = 14, x = 255, y = 323 }, { height = 15, text = "apart", width = 26, x = 273, y = 323 }, { height = 15, text = "from", width = 25, x = 302, y = 323 }, { height = 15, text = "the", width = 16, x = 330, y = 323 }, { height = 15, text = "secret", width = 30, x = 350, y = 323 }, { height = 15, text = "it", width = 7, x = 383, y = 323 }, { height = 15, text = "keeps", width = 29, x = 394, y = 323 }, { height = 15, text = "rather", width = 30, x = 9, y = 338 }, { height = 15, text = "than", width = 23, x = 43, y = 353 }, { height = 15, text = "to", width = 10, x = 69, y = 353 }, { height = 15, text = "play", width = 23, x = 82, y = 353 }, { height = 15, text = "like", width = 19, x = 73, y = 368 }, { height = 15, text = "a", width = 5, x = 96, y = 368 }, { height = 15, text = "hoary", width = 29, x = 105, y = 368 }, { height = 15, text = "maniac", width = 37, x = 138, y = 368 }, { height = 15, text = "the", width = 16, x = 131, y = 383 }, { height = 15, text = "game", width = 29, x = 150, y = 383 }, { height = 15, text = "in", width = 10, x = 81, y = 398 }, { height = 15, text = "the", width = 16, x = 95, y = 398 }, { height = 15, text = "name", width = 28, x = 114, y = 398 }, { height = 15, text = "of", width = 11, x = 145, y = 398 }, { height = 15, text = "waves", width = 33, x = 159, y = 398 }, { height = 15, text = "one", width = 19, x = 244, y = 413 }, { height = 15, text = "invades", width = 40, x = 266, y = 413 }, { height = 15, text = "the", width = 16, x = 309, y = 413 }, { height = 15, text = "chief", width = 26, x = 328, y = 413 }, { height = 15, text = "flows", width = 29, x = 272, y = 428 }, { height = 15, text = "like", width = 19, x = 304, y = 428 }, { height = 15, text = "a", width = 5, x = 327, y = 428 }, { height = 15, text = "submissive", width = 57, x = 336, y = 428 }, { height = 15, text = "beard", width = 29, x = 397, y = 428 }, { height = 15, text = "shipwreck", width = 54, x = 192, y = 459 }, { height = 15, text = "that", width = 20, x = 249, y = 459 }, { height = 15, text = "direct", width = 29, x = 272, y = 459 }, { height = 15, text = "from", width = 25, x = 305, y = 459 }, { height = 15, text = "man", width = 23, x = 333, y = 459 }, { height = 15, text = "sans", width = 22, x = 310, y = 490 }, { height = 15, text = "ship", width = 22, x = 335, y = 490 }, { height = 15, text = "no", width = 13, x = 333, y = 505 }, { height = 15, text = "matter", width = 33, x = 349, y = 505 }, { height = 15, text = "where", width = 31, x = 410, y = 536 }, { height = 15, text = "vain", width = 22, x = 445, y = 536 } ]
    , [ { height = 15, text = "ancestrally", width = 56, x = 1, y = 0 }, { height = 15, text = "to", width = 10, x = 61, y = 0 }, { height = 15, text = "not", width = 17, x = 74, y = 0 }, { height = 15, text = "open", width = 25, x = 94, y = 0 }, { height = 15, text = "the", width = 16, x = 122, y = 0 }, { height = 15, text = "hand", width = 26, x = 141, y = 0 }, { height = 15, text = "clenched", width = 46, x = 126, y = 15 }, { height = 15, text = "beyond", width = 38, x = 101, y = 30 }, { height = 15, text = "the", width = 15, x = 143, y = 30 }, { height = 15, text = "useless", width = 37, x = 162, y = 30 }, { height = 15, text = "head", width = 24, x = 202, y = 30 }, { height = 15, text = "legacy", width = 34, x = 41, y = 61 }, { height = 15, text = "in", width = 10, x = 78, y = 61 }, { height = 15, text = "the", width = 15, x = 92, y = 61 }, { height = 15, text = "disappearance", width = 73, x = 111, y = 61 }, { height = 15, text = "to", width = 10, x = 121, y = 92 }, { height = 15, text = "someone", width = 47, x = 134, y = 92 }, { height = 15, text = "ambiguous", width = 57, x = 196, y = 107 }, { height = 15, text = "the", width = 16, x = 106, y = 138 }, { height = 15, text = "last", width = 18, x = 125, y = 138 }, { height = 15, text = "immemorial", width = 64, x = 146, y = 138 }, { height = 15, text = "demon", width = 36, x = 213, y = 138 }, { height = 15, text = "having", width = 35, x = 1, y = 169 }, { height = 15, text = "from", width = 25, x = 51, y = 184 }, { height = 15, text = "null", width = 20, x = 80, y = 184 }, { height = 15, text = "regions", width = 38, x = 103, y = 184 }, { height = 15, text = "induced", width = 41, x = 126, y = 199 }, { height = 15, text = "the", width = 16, x = 1, y = 214 }, { height = 15, text = "old", width = 17, x = 20, y = 214 }, { height = 15, text = "man", width = 22, x = 40, y = 214 }, { height = 15, text = "towards", width = 41, x = 66, y = 214 }, { height = 15, text = "this", width = 19, x = 110, y = 214 }, { height = 15, text = "supreme", width = 44, x = 132, y = 214 }, { height = 15, text = "conjunction", width = 62, x = 179, y = 214 }, { height = 15, text = "with", width = 23, x = 244, y = 214 }, { height = 15, text = "probability", width = 57, x = 270, y = 214 }, { height = 15, text = "he", width = 12, x = 176, y = 245 }, { height = 15, text = "his", width = 15, x = 201, y = 260 }, { height = 15, text = "puerile", width = 37, x = 219, y = 260 }, { height = 15, text = "shade", width = 29, x = 259, y = 260 }, { height = 15, text = "caressed", width = 44, x = 1, y = 275 }, { height = 15, text = "and", width = 19, x = 48, y = 275 }, { height = 15, text = "polished", width = 44, x = 70, y = 275 }, { height = 15, text = "and", width = 18, x = 118, y = 275 }, { height = 15, text = "rendered", width = 45, x = 140, y = 275 }, { height = 15, text = "and", width = 19, x = 188, y = 275 }, { height = 15, text = "laved", width = 29, x = 210, y = 275 }, { height = 15, text = "made", width = 28, x = 126, y = 290 }, { height = 15, text = "supple", width = 34, x = 157, y = 290 }, { height = 15, text = "by", width = 13, x = 195, y = 290 }, { height = 15, text = "the", width = 16, x = 211, y = 290 }, { height = 15, text = "wave", width = 27, x = 230, y = 290 }, { height = 15, text = "and", width = 18, x = 261, y = 290 }, { height = 15, text = "abstracted", width = 52, x = 283, y = 290 }, { height = 15, text = "from", width = 25, x = 101, y = 305 }, { height = 15, text = "the", width = 15, x = 130, y = 305 }, { height = 15, text = "hard", width = 23, x = 149, y = 305 }, { height = 15, text = "bones", width = 30, x = 175, y = 305 }, { height = 15, text = "lost", width = 18, x = 209, y = 305 }, { height = 15, text = "between", width = 43, x = 231, y = 305 }, { height = 15, text = "the", width = 16, x = 277, y = 305 }, { height = 15, text = "planks", width = 34, x = 296, y = 305 }, { height = 15, text = "born", width = 24, x = 161, y = 336 }, { height = 15, text = "of", width = 11, x = 196, y = 351 }, { height = 15, text = "a", width = 6, x = 210, y = 351 }, { height = 15, text = "gambol", width = 39, x = 219, y = 351 }, { height = 15, text = "the", width = 16, x = 1, y = 382 }, { height = 15, text = "sea", width = 17, x = 20, y = 382 }, { height = 15, text = "with", width = 23, x = 40, y = 382 }, { height = 15, text = "the", width = 16, x = 66, y = 382 }, { height = 15, text = "grandfather", width = 59, x = 86, y = 382 }, { height = 15, text = "tempting", width = 46, x = 149, y = 382 }, { height = 15, text = "or", width = 11, x = 198, y = 382 }, { height = 15, text = "the", width = 16, x = 212, y = 382 }, { height = 15, text = "grandfather", width = 60, x = 231, y = 382 }, { height = 15, text = "against", width = 36, x = 295, y = 382 }, { height = 15, text = "the", width = 16, x = 335, y = 382 }, { height = 15, text = "sea", width = 16, x = 354, y = 382 }, { height = 15, text = "an", width = 12, x = 76, y = 397 }, { height = 15, text = "idle", width = 19, x = 92, y = 397 }, { height = 15, text = "chance", width = 36, x = 114, y = 397 }, { height = 15, text = "Betrothal", width = 48, x = 351, y = 428 }, { height = 15, text = "whose", width = 33, x = 1, y = 443 }, { height = 15, text = "veil", width = 20, x = 51, y = 458 }, { height = 15, text = "of", width = 11, x = 74, y = 458 }, { height = 15, text = "illusion", width = 39, x = 88, y = 458 }, { height = 15, text = "gushed", width = 37, x = 130, y = 458 }, { height = 15, text = "their", width = 24, x = 170, y = 458 }, { height = 15, text = "phobia", width = 36, x = 197, y = 458 }, { height = 15, text = "like", width = 20, x = 51, y = 473 }, { height = 15, text = "the", width = 16, x = 74, y = 473 }, { height = 15, text = "phantom", width = 45, x = 93, y = 473 }, { height = 15, text = "of", width = 10, x = 142, y = 473 }, { height = 15, text = "a", width = 6, x = 156, y = 473 }, { height = 15, text = "gesture", width = 37, x = 165, y = 473 }, { height = 15, text = "will", width = 20, x = 161, y = 504 }, { height = 15, text = "totter", width = 28, x = 184, y = 504 }, { height = 15, text = "will", width = 20, x = 161, y = 519 }, { height = 15, text = "fall", width = 18, x = 184, y = 519 }, { height = 15, text = "madness", width = 45, x = 251, y = 560 }, { height = 28, text = "WILL", width = 59, x = 371, y = 550 }, { height = 28, text = "ABOLISH", width = 104, x = 435, y = 550 } ]
    , [ { height = 18, text = "AS", width = 18, x = 1, y = 0 }, { height = 18, text = "IF", width = 15, x = 23, y = 0 }, { height = 15, text = "an", width = 13, x = 181, y = 34 }, { height = 15, text = "insinuation", width = 58, x = 197, y = 34 }, { height = 15, text = "simple", width = 33, x = 259, y = 34 }, { height = 15, text = "in", width = 10, x = 217, y = 65 }, { height = 15, text = "silence", width = 36, x = 230, y = 65 }, { height = 15, text = "rolled", width = 30, x = 270, y = 65 }, { height = 15, text = "with", width = 23, x = 303, y = 65 }, { height = 15, text = "irony", width = 27, x = 329, y = 65 }, { height = 15, text = "or", width = 12, x = 368, y = 80 }, { height = 15, text = "the", width = 16, x = 382, y = 95 }, { height = 15, text = "mystery", width = 40, x = 401, y = 95 }, { height = 15, text = "precipitated", width = 62, x = 393, y = 110 }, { height = 15, text = "howled", width = 37, x = 468, y = 125 }, { height = 15, text = "in", width = 10, x = 191, y = 156 }, { height = 15, text = "some", width = 26, x = 205, y = 156 }, { height = 15, text = "nearby", width = 36, x = 235, y = 156 }, { height = 15, text = "whirlpool", width = 51, x = 274, y = 156 }, { height = 15, text = "of", width = 10, x = 328, y = 156 }, { height = 15, text = "hilarity", width = 38, x = 341, y = 156 }, { height = 15, text = "or", width = 11, x = 383, y = 156 }, { height = 15, text = "horror", width = 34, x = 398, y = 156 }, { height = 15, text = "flutters", width = 36, x = 227, y = 187 }, { height = 15, text = "around", width = 37, x = 266, y = 187 }, { height = 15, text = "the", width = 16, x = 307, y = 187 }, { height = 15, text = "gulf", width = 20, x = 326, y = 187 }, { height = 15, text = "without", width = 39, x = 360, y = 218 }, { height = 15, text = "strewing", width = 45, x = 402, y = 218 }, { height = 15, text = "it", width = 7, x = 450, y = 218 }, { height = 15, text = "nor", width = 18, x = 476, y = 233 }, { height = 15, text = "fleeing", width = 35, x = 497, y = 233 }, { height = 15, text = "and", width = 19, x = 347, y = 264 }, { height = 15, text = "cradles", width = 39, x = 369, y = 264 }, { height = 15, text = "the", width = 16, x = 411, y = 264 }, { height = 15, text = "virgin", width = 31, x = 430, y = 264 }, { height = 15, text = "index", width = 28, x = 464, y = 264 }, { height = 18, text = "AS", width = 18, x = 535, y = 295 }, { height = 18, text = "IF", width = 15, x = 557, y = 295 } ]
    , [ { height = 15, text = "plume", width = 32, x = 51, y = 0 }, { height = 15, text = "solitary", width = 40, x = 86, y = 0 }, { height = 15, text = "distraught", width = 53, x = 129, y = 0 }, { height = 15, text = "save", width = 23, x = 214, y = 99 }, { height = 15, text = "that", width = 20, x = 240, y = 99 }, { height = 15, text = "encounters", width = 57, x = 264, y = 99 }, { height = 15, text = "or", width = 11, x = 324, y = 99 }, { height = 15, text = "skims", width = 29, x = 339, y = 99 }, { height = 15, text = "it", width = 7, x = 371, y = 99 }, { height = 15, text = "a", width = 7, x = 381, y = 99 }, { height = 15, text = "midnight", width = 46, x = 391, y = 99 }, { height = 15, text = "cap", width = 18, x = 441, y = 99 }, { height = 15, text = "and", width = 20, x = 369, y = 114 }, { height = 15, text = "immobilizes", width = 62, x = 392, y = 114 }, { height = 15, text = "in", width = 10, x = 286, y = 129 }, { height = 15, text = "velvet", width = 30, x = 299, y = 129 }, { height = 15, text = "crumpled", width = 49, x = 333, y = 129 }, { height = 15, text = "by", width = 12, x = 385, y = 129 }, { height = 15, text = "a", width = 6, x = 401, y = 129 }, { height = 15, text = "guffaw", width = 36, x = 410, y = 129 }, { height = 15, text = "somber", width = 38, x = 449, y = 129 }, { height = 15, text = "that", width = 21, x = 369, y = 160 }, { height = 15, text = "rigid", width = 25, x = 393, y = 160 }, { height = 15, text = "whiteness", width = 51, x = 421, y = 160 }, { height = 15, text = "derisory", width = 43, x = 201, y = 191 }, { height = 15, text = "in", width = 10, x = 411, y = 222 }, { height = 15, text = "opposition", width = 55, x = 425, y = 222 }, { height = 15, text = "to", width = 10, x = 483, y = 222 }, { height = 15, text = "the", width = 16, x = 496, y = 222 }, { height = 15, text = "sky", width = 17, x = 515, y = 222 }, { height = 15, text = "too", width = 17, x = 274, y = 253 }, { height = 15, text = "much", width = 28, x = 294, y = 253 }, { height = 15, text = "for", width = 16, x = 390, y = 268 }, { height = 15, text = "not", width = 16, x = 409, y = 268 }, { height = 15, text = "marking", width = 43, x = 429, y = 268 }, { height = 15, text = "exiguously", width = 56, x = 441, y = 283 }, { height = 15, text = "whosoever", width = 56, x = 466, y = 298 }, { height = 15, text = "bitter", width = 28, x = 372, y = 329 }, { height = 15, text = "prince", width = 33, x = 403, y = 329 }, { height = 15, text = "of", width = 10, x = 440, y = 329 }, { height = 15, text = "the", width = 16, x = 453, y = 329 }, { height = 15, text = "reef", width = 20, x = 472, y = 329 }, { height = 15, text = "puts", width = 22, x = 421, y = 360 }, { height = 15, text = "it", width = 8, x = 446, y = 360 }, { height = 15, text = "on", width = 13, x = 457, y = 360 }, { height = 15, text = "like", width = 19, x = 473, y = 360 }, { height = 15, text = "the", width = 16, x = 495, y = 360 }, { height = 15, text = "heroic", width = 33, x = 514, y = 360 }, { height = 15, text = "irresistible", width = 56, x = 407, y = 375 }, { height = 15, text = "but", width = 16, x = 466, y = 375 }, { height = 15, text = "contained", width = 51, x = 486, y = 375 }, { height = 15, text = "by", width = 13, x = 400, y = 390 }, { height = 15, text = "his", width = 15, x = 416, y = 390 }, { height = 15, text = "little", width = 24, x = 434, y = 390 }, { height = 15, text = "reason", width = 35, x = 461, y = 390 }, { height = 15, text = "virile", width = 27, x = 500, y = 390 }, { height = 15, text = "in", width = 10, x = 512, y = 405 }, { height = 15, text = "lightning", width = 47, x = 525, y = 405 } ]
    , [ { height = 15, text = "concerned", width = 54, x = 1, y = 0 }, { height = 15, text = "expiatory", width = 49, x = 76, y = 15 }, { height = 15, text = "and", width = 20, x = 128, y = 15 }, { height = 15, text = "pubescent", width = 52, x = 151, y = 15 }, { height = 15, text = "mute", width = 25, x = 251, y = 30 }, { height = 15, text = "laughter", width = 44, x = 351, y = 30 }, { height = 15, text = "that", width = 20, x = 432, y = 61 }, { height = 18, text = "IF", width = 15, x = 477, y = 92 }, { height = 15, text = "The", width = 19, x = 73, y = 141 }, { height = 15, text = "lucid", width = 26, x = 95, y = 141 }, { height = 15, text = "and", width = 19, x = 125, y = 141 }, { height = 15, text = "seigniorial", width = 57, x = 147, y = 141 }, { height = 15, text = "aigrette", width = 40, x = 207, y = 141 }, { height = 15, text = "of", width = 10, x = 250, y = 141 }, { height = 15, text = "vertigo", width = 36, x = 264, y = 141 }, { height = 15, text = "with", width = 22, x = 112, y = 156 }, { height = 15, text = "invisible", width = 44, x = 138, y = 156 }, { height = 15, text = "brow", width = 26, x = 185, y = 156 }, { height = 15, text = "scintillates", width = 56, x = 96, y = 171 }, { height = 15, text = "then", width = 23, x = 151, y = 186 }, { height = 15, text = "shadows", width = 45, x = 177, y = 186 }, { height = 15, text = "stature", width = 36, x = 139, y = 201 }, { height = 15, text = "dainty", width = 33, x = 178, y = 201 }, { height = 15, text = "tenebrous", width = 51, x = 214, y = 201 }, { height = 15, text = "erect", width = 25, x = 268, y = 201 }, { height = 15, text = "in", width = 10, x = 138, y = 216 }, { height = 15, text = "its", width = 12, x = 151, y = 216 }, { height = 15, text = "siren", width = 25, x = 167, y = 216 }, { height = 15, text = "torsion", width = 37, x = 195, y = 216 }, { height = 15, text = "time", width = 22, x = 313, y = 231 }, { height = 15, text = "to", width = 10, x = 319, y = 246 }, { height = 15, text = "slap", width = 22, x = 332, y = 246 }, { height = 15, text = "with", width = 22, x = 106, y = 261 }, { height = 15, text = "impatient", width = 49, x = 131, y = 261 }, { height = 15, text = "scales", width = 31, x = 184, y = 261 }, { height = 15, text = "ultimate", width = 42, x = 219, y = 261 }, { height = 15, text = "bifurcated", width = 53, x = 264, y = 261 } ]
    , [ { height = 15, text = "a", width = 6, x = 380, y = 0 }, { height = 15, text = "rock", width = 23, x = 389, y = 0 }, { height = 15, text = "false", width = 25, x = 320, y = 31 }, { height = 15, text = "manor", width = 34, x = 348, y = 31 }, { height = 15, text = "right", width = 25, x = 351, y = 46 }, { height = 15, text = "away", width = 27, x = 380, y = 46 }, { height = 15, text = "evaporated", width = 59, x = 395, y = 61 }, { height = 15, text = "in", width = 10, x = 457, y = 61 }, { height = 15, text = "mists", width = 27, x = 470, y = 61 }, { height = 15, text = "that", width = 20, x = 390, y = 92 }, { height = 15, text = "imposed", width = 43, x = 414, y = 92 }, { height = 15, text = "a", width = 6, x = 443, y = 107 }, { height = 15, text = "limit", width = 23, x = 453, y = 107 }, { height = 15, text = "on", width = 13, x = 480, y = 107 }, { height = 15, text = "infinity", width = 36, x = 496, y = 107 }, { height = 18, text = "IT", width = 14, x = 138, y = 138 }, { height = 18, text = "WAS", width = 30, x = 155, y = 138 }, { height = 15, text = "stellar", width = 34, x = 135, y = 158 }, { height = 15, text = "issue", width = 26, x = 172, y = 158 }, { height = 18, text = "NUMBER", width = 65, x = 373, y = 156 }, { height = 18, text = "EXISTED", width = 67, x = 365, y = 190 }, { height = 18, text = "HE", width = 21, x = 436, y = 190 }, { height = 13, text = "otherwise", width = 39, x = 343, y = 208 }, { height = 13, text = "than", width = 17, x = 384, y = 208 }, { height = 13, text = "scattered", width = 35, x = 404, y = 208 }, { height = 13, text = "hallucination", width = 52, x = 442, y = 208 }, { height = 13, text = "of", width = 8, x = 497, y = 208 }, { height = 13, text = "agony", width = 24, x = 508, y = 208 }, { height = 18, text = "COMMENCED", width = 104, x = 273, y = 237 }, { height = 18, text = "HE", width = 22, x = 381, y = 237 }, { height = 18, text = "AND", width = 34, x = 406, y = 237 }, { height = 18, text = "CEASED", width = 63, x = 444, y = 237 }, { height = 18, text = "HE", width = 21, x = 511, y = 237 }, { height = 13, text = "upwelling", width = 40, x = 316, y = 255 }, { height = 13, text = "but", width = 13, x = 359, y = 255 }, { height = 13, text = "denied", width = 27, x = 374, y = 255 }, { height = 13, text = "and", width = 15, x = 403, y = 255 }, { height = 13, text = "closed", width = 26, x = 420, y = 255 }, { height = 13, text = "when", width = 22, x = 448, y = 255 }, { height = 13, text = "apparent", width = 34, x = 473, y = 255 }, { height = 13, text = "at", width = 8, x = 333, y = 268 }, { height = 13, text = "last", width = 14, x = 343, y = 268 }, { height = 13, text = "by", width = 10, x = 325, y = 281 }, { height = 13, text = "some", width = 21, x = 338, y = 281 }, { height = 13, text = "profusion", width = 39, x = 361, y = 281 }, { height = 13, text = "widespread", width = 46, x = 402, y = 281 }, { height = 13, text = "in", width = 8, x = 450, y = 281 }, { height = 13, text = "rarity", width = 22, x = 460, y = 281 }, { height = 18, text = "CIPHERED", width = 79, x = 363, y = 294 }, { height = 18, text = "HE", width = 21, x = 446, y = 294 }, { height = 13, text = "evidence", width = 35, x = 306, y = 332 }, { height = 13, text = "of", width = 8, x = 344, y = 332 }, { height = 13, text = "the", width = 12, x = 355, y = 332 }, { height = 13, text = "sum", width = 17, x = 369, y = 332 }, { height = 13, text = "if", width = 6, x = 389, y = 332 }, { height = 13, text = "only", width = 18, x = 397, y = 332 }, { height = 13, text = "one", width = 14, x = 418, y = 332 }, { height = 18, text = "ILLUMINATED", width = 109, x = 373, y = 346 }, { height = 18, text = "HE", width = 21, x = 486, y = 346 }, { height = 18, text = "IT", width = 14, x = 1, y = 380 }, { height = 18, text = "WOULD", width = 57, x = 19, y = 380 }, { height = 18, text = "BE", width = 19, x = 80, y = 380 }, { height = 13, text = "worse", width = 24, x = 51, y = 398 }, { height = 13, text = "no", width = 10, x = 126, y = 411 }, { height = 13, text = "more", width = 20, x = 151, y = 424 }, { height = 13, text = "nor", width = 14, x = 174, y = 424 }, { height = 13, text = "less", width = 15, x = 190, y = 424 }, { height = 13, text = "indifferently", width = 49, x = 101, y = 449 }, { height = 13, text = "but", width = 13, x = 152, y = 449 }, { height = 13, text = "as", width = 9, x = 167, y = 449 }, { height = 13, text = "much", width = 21, x = 179, y = 449 } ]
    , [ { height = 28, text = "CHANCE", width = 99, x = 275, y = 0 }, { height = 15, text = "Falls", width = 27, x = 230, y = 78 }, { height = 15, text = "the", width = 16, x = 261, y = 93 }, { height = 15, text = "plume", width = 32, x = 280, y = 93 }, { height = 15, text = "rhythmic", width = 46, x = 322, y = 108 }, { height = 15, text = "suspense", width = 46, x = 372, y = 108 }, { height = 15, text = "of", width = 10, x = 421, y = 108 }, { height = 15, text = "the", width = 15, x = 435, y = 108 }, { height = 15, text = "sinister", width = 38, x = 454, y = 108 }, { height = 15, text = "to", width = 10, x = 481, y = 123 }, { height = 15, text = "bury", width = 23, x = 495, y = 123 }, { height = 15, text = "itself", width = 25, x = 522, y = 123 }, { height = 15, text = "in", width = 11, x = 467, y = 138 }, { height = 15, text = "original", width = 42, x = 481, y = 138 }, { height = 15, text = "foams", width = 31, x = 526, y = 138 }, { height = 15, text = "not", width = 16, x = 275, y = 153 }, { height = 15, text = "long", width = 24, x = 294, y = 153 }, { height = 15, text = "ago", width = 19, x = 321, y = 153 }, { height = 15, text = "whence", width = 39, x = 344, y = 153 }, { height = 15, text = "sprang", width = 36, x = 386, y = 153 }, { height = 15, text = "up", width = 13, x = 425, y = 153 }, { height = 15, text = "its", width = 13, x = 441, y = 153 }, { height = 15, text = "delirium", width = 44, x = 457, y = 153 }, { height = 15, text = "to", width = 10, x = 504, y = 153 }, { height = 15, text = "a", width = 6, x = 518, y = 153 }, { height = 15, text = "peak", width = 25, x = 527, y = 153 }, { height = 15, text = "withered", width = 45, x = 467, y = 168 }, { height = 15, text = "by", width = 12, x = 342, y = 183 }, { height = 15, text = "the", width = 15, x = 358, y = 183 }, { height = 15, text = "identical", width = 45, x = 377, y = 183 }, { height = 15, text = "neutrality", width = 51, x = 425, y = 183 }, { height = 15, text = "of", width = 10, x = 479, y = 183 }, { height = 15, text = "the", width = 16, x = 493, y = 183 }, { height = 15, text = "gulf", width = 20, x = 512, y = 183 } ]
    , [ { height = 18, text = "NOTHING", width = 73, x = 1, y = 0 }, { height = 15, text = "of", width = 11, x = 101, y = 68 }, { height = 15, text = "the", width = 16, x = 115, y = 68 }, { height = 15, text = "memorable", width = 59, x = 134, y = 68 }, { height = 15, text = "crisis", width = 27, x = 196, y = 68 }, { height = 15, text = "when", width = 28, x = 151, y = 83 }, { height = 15, text = "might", width = 31, x = 182, y = 83 }, { height = 15, text = "the", width = 16, x = 176, y = 98 }, { height = 15, text = "event", width = 28, x = 195, y = 98 }, { height = 15, text = "have", width = 24, x = 227, y = 98 }, { height = 15, text = "been", width = 25, x = 254, y = 98 }, { height = 15, text = "accomplished", width = 72, x = 282, y = 98 }, { height = 15, text = "in", width = 10, x = 357, y = 98 }, { height = 15, text = "view", width = 26, x = 370, y = 98 }, { height = 15, text = "of", width = 11, x = 399, y = 98 }, { height = 15, text = "every", width = 29, x = 413, y = 98 }, { height = 15, text = "result", width = 29, x = 445, y = 98 }, { height = 15, text = "null", width = 20, x = 477, y = 98 }, { height = 15, text = "human", width = 35, x = 526, y = 113 }, { height = 18, text = "WILL", width = 40, x = 335, y = 144 }, { height = 18, text = "HAVE", width = 43, x = 378, y = 144 }, { height = 18, text = "TAKEN", width = 52, x = 425, y = 144 }, { height = 18, text = "PLACE", width = 51, x = 481, y = 144 }, { height = 15, text = "an", width = 12, x = 345, y = 162 }, { height = 15, text = "ordinary", width = 44, x = 361, y = 162 }, { height = 15, text = "elevation", width = 47, x = 408, y = 162 }, { height = 15, text = "pours", width = 29, x = 459, y = 162 }, { height = 15, text = "absence", width = 41, x = 491, y = 162 }, { height = 18, text = "BUT", width = 32, x = 426, y = 193 }, { height = 18, text = "THE", width = 31, x = 461, y = 193 }, { height = 18, text = "PLACE", width = 51, x = 496, y = 193 }, { height = 15, text = "inferior", width = 39, x = 280, y = 211 }, { height = 15, text = "lapping", width = 39, x = 322, y = 211 }, { height = 15, text = "whatsoever", width = 60, x = 364, y = 211 }, { height = 15, text = "as", width = 11, x = 427, y = 211 }, { height = 15, text = "if", width = 8, x = 441, y = 211 }, { height = 15, text = "to", width = 10, x = 452, y = 211 }, { height = 15, text = "disperse", width = 43, x = 465, y = 211 }, { height = 15, text = "the", width = 16, x = 511, y = 211 }, { height = 15, text = "act", width = 16, x = 530, y = 211 }, { height = 15, text = "void", width = 23, x = 549, y = 211 }, { height = 15, text = "abruptly", width = 43, x = 363, y = 226 }, { height = 15, text = "which", width = 32, x = 409, y = 226 }, { height = 15, text = "if", width = 8, x = 444, y = 226 }, { height = 15, text = "not", width = 17, x = 455, y = 226 }, { height = 15, text = "by", width = 13, x = 340, y = 241 }, { height = 15, text = "its", width = 12, x = 356, y = 241 }, { height = 15, text = "falsehood", width = 51, x = 371, y = 241 }, { height = 15, text = "might", width = 30, x = 318, y = 256 }, { height = 15, text = "have", width = 24, x = 352, y = 256 }, { height = 15, text = "founded", width = 43, x = 379, y = 256 }, { height = 15, text = "perdition", width = 47, x = 375, y = 271 }, { height = 15, text = "in", width = 10, x = 215, y = 302 }, { height = 15, text = "those", width = 27, x = 228, y = 302 }, { height = 15, text = "regions", width = 38, x = 259, y = 302 }, { height = 15, text = "of", width = 11, x = 326, y = 317 }, { height = 15, text = "the", width = 16, x = 340, y = 317 }, { height = 15, text = "wave", width = 27, x = 360, y = 317 }, { height = 15, text = "in", width = 10, x = 423, y = 332 }, { height = 15, text = "which", width = 31, x = 437, y = 332 }, { height = 15, text = "all", width = 13, x = 472, y = 332 }, { height = 15, text = "reality", width = 33, x = 488, y = 332 }, { height = 15, text = "dissolves", width = 48, x = 524, y = 332 } ]
    , [ { height = 18, text = "EXCEPT", width = 60, x = 1, y = 0 }, { height = 15, text = "at", width = 9, x = 51, y = 20 }, { height = 15, text = "the", width = 16, x = 64, y = 20 }, { height = 15, text = "altitude", width = 39, x = 83, y = 20 }, { height = 18, text = "PERHAPS", width = 70, x = 126, y = 36 }, { height = 15, text = "as", width = 11, x = 176, y = 54 }, { height = 15, text = "far", width = 15, x = 190, y = 54 }, { height = 15, text = "as", width = 11, x = 208, y = 54 }, { height = 15, text = "a", width = 6, x = 222, y = 54 }, { height = 15, text = "place", width = 27, x = 231, y = 54 }, { height = 15, text = "fuses", width = 26, x = 262, y = 54 }, { height = 15, text = "with", width = 23, x = 292, y = 54 }, { height = 15, text = "beyond", width = 38, x = 318, y = 54 }, { height = 15, text = "apart", width = 26, x = 357, y = 85 }, { height = 15, text = "from", width = 25, x = 386, y = 85 }, { height = 15, text = "the", width = 15, x = 415, y = 85 }, { height = 15, text = "interest", width = 38, x = 434, y = 85 }, { height = 15, text = "as", width = 11, x = 316, y = 100 }, { height = 15, text = "to", width = 10, x = 330, y = 100 }, { height = 15, text = "it", width = 7, x = 343, y = 100 }, { height = 15, text = "signaled", width = 43, x = 354, y = 100 }, { height = 15, text = "in", width = 10, x = 505, y = 115 }, { height = 15, text = "general", width = 38, x = 519, y = 115 }, { height = 15, text = "according", width = 51, x = 263, y = 130 }, { height = 15, text = "to", width = 11, x = 317, y = 130 }, { height = 15, text = "such", width = 24, x = 331, y = 130 }, { height = 15, text = "obliquity", width = 47, x = 358, y = 130 }, { height = 15, text = "by", width = 13, x = 408, y = 130 }, { height = 15, text = "such", width = 24, x = 424, y = 130 }, { height = 15, text = "declivity", width = 45, x = 452, y = 130 }, { height = 15, text = "of", width = 10, x = 511, y = 145 }, { height = 15, text = "fires", width = 22, x = 525, y = 145 }, { height = 15, text = "toward", width = 36, x = 286, y = 160 }, { height = 15, text = "this", width = 19, x = 309, y = 191 }, { height = 15, text = "must", width = 25, x = 331, y = 191 }, { height = 15, text = "be", width = 12, x = 360, y = 191 }, { height = 15, text = "the", width = 16, x = 335, y = 206 }, { height = 15, text = "Septentrion", width = 60, x = 354, y = 206 }, { height = 15, text = "also", width = 21, x = 417, y = 206 }, { height = 15, text = "North", width = 30, x = 442, y = 206 }, { height = 18, text = "A", width = 11, x = 428, y = 237 }, { height = 18, text = "CONSTELLATION", width = 130, x = 442, y = 237 } ]
    , [ { height = 15, text = "cold", width = 22, x = 328, y = 0 }, { height = 15, text = "from", width = 25, x = 353, y = 0 }, { height = 15, text = "forgetting", width = 51, x = 382, y = 0 }, { height = 15, text = "and", width = 19, x = 436, y = 0 }, { height = 15, text = "desuetude", width = 52, x = 458, y = 0 }, { height = 15, text = "not", width = 17, x = 446, y = 15 }, { height = 15, text = "so", width = 12, x = 466, y = 15 }, { height = 15, text = "much", width = 29, x = 481, y = 15 }, { height = 15, text = "that", width = 19, x = 398, y = 30 }, { height = 15, text = "it", width = 8, x = 420, y = 30 }, { height = 15, text = "does", width = 24, x = 431, y = 30 }, { height = 15, text = "not", width = 17, x = 458, y = 30 }, { height = 15, text = "enumerate", width = 54, x = 478, y = 30 }, { height = 15, text = "on", width = 13, x = 382, y = 45 }, { height = 15, text = "some", width = 27, x = 399, y = 45 }, { height = 15, text = "surface", width = 38, x = 429, y = 45 }, { height = 15, text = "vacant", width = 34, x = 470, y = 45 }, { height = 15, text = "and", width = 19, x = 507, y = 45 }, { height = 15, text = "superior", width = 43, x = 529, y = 45 }, { height = 15, text = "the", width = 16, x = 398, y = 60 }, { height = 15, text = "successive", width = 55, x = 417, y = 60 }, { height = 15, text = "clash", width = 27, x = 475, y = 60 }, { height = 15, text = "sidereally", width = 51, x = 471, y = 75 }, { height = 15, text = "of", width = 11, x = 366, y = 90 }, { height = 15, text = "a", width = 6, x = 380, y = 90 }, { height = 15, text = "total", width = 23, x = 389, y = 90 }, { height = 15, text = "count", width = 29, x = 415, y = 90 }, { height = 15, text = "in", width = 10, x = 447, y = 90 }, { height = 15, text = "formation", width = 51, x = 461, y = 90 }, { height = 15, text = "watching", width = 48, x = 249, y = 105 }, { height = 15, text = "doubting", width = 46, x = 311, y = 120 }, { height = 15, text = "rolling", width = 35, x = 367, y = 135 }, { height = 15, text = "shining", width = 38, x = 418, y = 150 }, { height = 15, text = "and", width = 19, x = 459, y = 150 }, { height = 15, text = "meditating", width = 56, x = 481, y = 150 }, { height = 15, text = "before", width = 33, x = 476, y = 181 }, { height = 15, text = "stopping", width = 45, x = 512, y = 181 }, { height = 15, text = "at", width = 10, x = 384, y = 196 }, { height = 15, text = "some", width = 27, x = 397, y = 196 }, { height = 15, text = "last", width = 18, x = 428, y = 196 }, { height = 15, text = "point", width = 27, x = 449, y = 196 }, { height = 15, text = "that", width = 19, x = 479, y = 196 }, { height = 15, text = "consecrates", width = 60, x = 502, y = 196 }, { height = 15, text = "it", width = 7, x = 565, y = 196 }, { height = 15, text = "Every", width = 31, x = 323, y = 227 }, { height = 15, text = "Thought", width = 44, x = 358, y = 227 }, { height = 15, text = "sends", width = 29, x = 405, y = 227 }, { height = 15, text = "forth", width = 25, x = 437, y = 227 }, { height = 15, text = "one", width = 18, x = 466, y = 227 }, { height = 15, text = "Toss", width = 24, x = 487, y = 227 }, { height = 15, text = "of", width = 11, x = 514, y = 227 }, { height = 15, text = "the", width = 16, x = 528, y = 227 }, { height = 15, text = "Dice", width = 25, x = 547, y = 227 } ]
    ]


paginate : List Word -> List (List Word)
paginate =
    let
        go : List String -> List Word -> List (List Word)
        go markers inputWords =
            case markers of
                [] ->
                    [ inputWords ]

                marker :: subsequentMarkers ->
                    let
                        offset =
                            List.Extra.find (.text >> (==) marker) inputWords
                                |> Maybe.map .y
                                |> Maybe.withDefault 0
                    in
                    case List.Extra.splitWhen (.text >> (==) marker) inputWords of
                        Nothing ->
                            [ inputWords ]

                        Just ( thisPage, subsequent ) ->
                            thisPage :: go subsequentMarkers (List.map (\word -> { word | y = word.y - offset }) subsequent)
    in
    go
        [ "WHETHER"
        , "THE"
        , "ancestrally"
        , "AS"
        , "plume"
        , "concerned"
        , "a"
        , "CHANCE"
        , "NOTHING"
        , "EXCEPT"
        , "cold"
        ]


mergePhrases : List Word -> List Word
mergePhrases inputWords =
    let
        ( finalWord, result ) =
            List.foldl
                (\word ( maybeBuiltWord, accum ) ->
                    case maybeBuiltWord of
                        Nothing ->
                            ( Just word, [] )

                        Just builtWord ->
                            if
                                (builtWord.height /= word.height)
                                    || (builtWord.y /= word.y)
                            then
                                ( Just word, builtWord :: accum )

                            else
                                ( Just
                                    { builtWord
                                        | text = builtWord.text ++ " " ++ word.text
                                        , width = word.width + (word.x - builtWord.x)
                                    }
                                , accum
                                )
                )
                ( Nothing, [] )
                inputWords
    in
    case finalWord of
        Nothing ->
            List.reverse result

        Just word ->
            List.reverse <| word :: result
