module Poem exposing (..)


type alias Word =
    { text : String
    , x : Int
    , y : Int
    , width : Int
    , height : Int
    }


pages =
    [ []
    , [ { text = "A THROW OF THE DICE", x = 113, y = 194, width = 390, height = 41 } ]
    , []
    , [ { text = "NEVER", x = 90, y = 525, width = 120, height = 41 }, { text = "EVEN IF THROWN IN ETERNAL", x = 108, y = 692, width = 205, height = 17 } ]
    , [ { text = "CIRCUMSTANCES", x = 90, y = 87, width = 117, height = 17 }, { text = "FROM THE DEPTH OF A SHIPWRECK", x = 206, y = 168, width = 238, height = 17 }, { text = "WHETHER", x = 90, y = 249, width = 45, height = 10 }, { text = "the", x = 134, y = 269, width = 11, height = 10 }, { text = "Gulf", x = 181, y = 311, width = 16, height = 10 }, { text = "whitened", x = 134, y = 352, width = 34, height = 10 }, { text = "becalmed", x = 169, y = 362, width = 35, height = 10 }, { text = "furious", x = 205, y = 373, width = 26, height = 10 }, { text = "under a flat", x = 233, y = 383, width = 41, height = 10 }, { text = "incline desperately", x = 260, y = 393, width = 68, height = 10 }, { text = "from a wing", x = 317, y = 414, width = 45, height = 10 }, { text = "its own", x = 302, y = 445, width = 26, height = 10 }, { text = "by", x = 368, y = 466, width = 9, height = 10 } ]
    , [ { text = "advance declined from an evil to lift up the flight", x = 90, y = 475, width = 178, height = 10 }, { text = "and covering the spurts", x = 185, y = 485, width = 85, height = 10 }, { text = "and cutting short the leaps", x = 207, y = 496, width = 96, height = 10 }, { text = "completely sum up inside", x = 121, y = 527, width = 93, height = 10 }, { text = "the shadow buried in the depths by this alternative veil", x = 90, y = 548, width = 199, height = 10 }, { text = "as far as to adapt", x = 205, y = 568, width = 61, height = 10 }, { text = "to the breadth", x = 229, y = 579, width = 50, height = 10 }, { text = "its gaping depth as long as the hull", x = 152, y = 599, width = 126, height = 10 }, { text = "of a ship", x = 218, y = 620, width = 31, height = 10 }, { text = "tilted by one or the other edge", x = 187, y = 641, width = 109, height = 10 } ]
    , [ { text = "THE MASTER", x = 262, y = 258, width = 57, height = 10 }, { text = "appeared", x = 163, y = 289, width = 33, height = 10 }, { text = "deducing", x = 196, y = 299, width = 33, height = 10 }, { text = "of this upheaval", x = 280, y = 320, width = 58, height = 10 }, { text = "that", x = 311, y = 351, width = 13, height = 10 }, { text = "as one threatens", x = 286, y = 382, width = 59, height = 10 }, { text = "the unique number that can not", x = 203, y = 403, width = 113, height = 10 }, { text = "hesitates", x = 300, y = 475, width = 31, height = 10 }, { text = "corpse by the arm", x = 251, y = 485, width = 65, height = 10 }, { text = "rather", x = 90, y = 496, width = 21, height = 10 }, { text = "that to play", x = 112, y = 506, width = 41, height = 10 }, { text = "maniacal, grey with age", x = 152, y = 517, width = 87, height = 10 }, { text = "the part", x = 196, y = 527, width = 27, height = 10 }, { text = "in the name of the waves", x = 176, y = 537, width = 91, height = 10 }, { text = "one", x = 317, y = 548, width = 13, height = 10 }, { text = "shipwreck that", x = 271, y = 579, width = 53, height = 10 } ]
    , [ { text = "outside of ancient calculations", x = 244, y = 278, width = 111, height = 10 }, { text = "where the maneuver, forgotten, with age", x = 231, y = 289, width = 147, height = 10 }, { text = "formerly he grasped the helm", x = 289, y = 320, width = 107, height = 10 }, { text = "of the unanimous horizon", x = 169, y = 341, width = 94, height = 10 }, { text = "at his feet", x = 258, y = 351, width = 35, height = 10 }, { text = "gets it ready", x = 172, y = 372, width = 44, height = 10 }, { text = "stirs and mixes", x = 192, y = 382, width = 54, height = 10 }, { text = "with the fist which would embrace him", x = 209, y = 392, width = 142, height = 10 }, { text = "a fate and the winds", x = 172, y = 403, width = 72, height = 10 }, { text = "be another", x = 174, y = 423, width = 38, height = 10 }, { text = "Mind", x = 220, y = 444, width = 20, height = 10 }, { text = "to throw it", x = 238, y = 454, width = 38, height = 10 }, { text = "in the storm", x = 275, y = 465, width = 44, height = 10 }, { text = "to re-bend the division and to cross proudly", x = 253, y = 475, width = 159, height = 10 }, { text = "pushed aside from the secret he holds", x = 176, y = 496, width = 137, height = 10 }, { text = "invades the leader", x = 178, y = 558, width = 66, height = 10 }, { text = "sinks in subdued beard", x = 178, y = 568, width = 84, height = 10 }, { text = "direct from the man", x = 178, y = 589, width = 72, height = 10 }, { text = "without a nave", x = 211, y = 610, width = 54, height = 10 }, { text = "anywhere", x = 236, y = 620, width = 35, height = 10 }, { text = "vain", x = 269, y = 630, width = 15, height = 10 } ]
    , [ { text = "ancestrally not to open the hand", x = 90, y = 299, width = 116, height = 10 }, { text = "wrinkled", x = 189, y = 310, width = 33, height = 10 }, { text = "beyond the useless head", x = 167, y = 320, width = 88, height = 10 }, { text = "legacies in the disappearance", x = 117, y = 341, width = 105, height = 10 }, { text = "of somebody", x = 172, y = 361, width = 47, height = 10 }, { text = "ambiguous", x = 216, y = 372, width = 40, height = 10 }, { text = "the last, age-old, demon", x = 147, y = 392, width = 88, height = 10 }, { text = "with", x = 90, y = 413, width = 16, height = 10 }, { text = "the nonexistent countries", x = 112, y = 423, width = 91, height = 10 }, { text = "induces", x = 200, y = 434, width = 28, height = 10 }, { text = "the old man into this supreme conjunction with probability", x = 90, y = 444, width = 214, height = 10 }, { text = "that", x = 249, y = 465, width = 14, height = 10 }, { text = "his childish shadow", x = 264, y = 475, width = 72, height = 10 }, { text = "caressed and polished and returned and washed", x = 90, y = 485, width = 172, height = 10 }, { text = "softened by the wave and subtracted", x = 194, y = 496, width = 132, height = 10 }, { text = "from the tough bone lost between the planks", x = 181, y = 506, width = 161, height = 10 }, { text = "born", x = 286, y = 527, width = 17, height = 10 }, { text = "of a frolic", x = 302, y = 537, width = 36, height = 10 }, { text = "the sea by the tempting ancestor or the ancestor against the sea", x = 90, y = 548, width = 228, height = 10 }, { text = "an idle chance", x = 172, y = 558, width = 52, height = 10 }, { text = "Engagement", x = 304, y = 579, width = 45, height = 10 }, { text = "which", x = 90, y = 589, width = 22, height = 10 }, { text = "the veil of illusion spattered their obsession", x = 112, y = 599, width = 158, height = 10 }, { text = "as well as the ghost of a gesture", x = 112, y = 610, width = 116, height = 10 }, { text = "will hesitate", x = 196, y = 630, width = 44, height = 10 }, { text = "will collapse", x = 196, y = 641, width = 46, height = 10 }, { text = "madness", x = 242, y = 672, width = 32, height = 10 } ]
    , []
    , [ { text = "WILL ABOLISH", x = 152, y = 287, width = 251, height = 41 }, { text = "AS IF", x = 90, y = 341, width = 21, height = 10 }, { text = "An insinuation", x = 353, y = 372, width = 53, height = 10 }, { text = "in the silence", x = 366, y = 392, width = 48, height = 10 }, { text = "in some close", x = 361, y = 444, width = 49, height = 10 }, { text = "acrobatics", x = 377, y = 465, width = 38, height = 10 } ]
    , [ { text = "simple", x = 90, y = 392, width = 24, height = 10 }, { text = "rolled up with irony", x = 92, y = 413, width = 72, height = 10 }, { text = "or", x = 147, y = 423, width = 9, height = 10 }, { text = "the hasty", x = 152, y = 434, width = 33, height = 10 }, { text = "mystery", x = 176, y = 444, width = 28, height = 10 }, { text = "screamed", x = 196, y = 454, width = 34, height = 10 }, { text = "whirlwind of hilarity and of horror", x = 90, y = 475, width = 127, height = 10 }, { text = "around the abyss", x = 90, y = 496, width = 62, height = 10 }, { text = "without sprinkling", x = 156, y = 506, width = 67, height = 10 }, { text = "or running away", x = 209, y = 517, width = 61, height = 10 }, { text = "and rocking the blank index", x = 154, y = 537, width = 101, height = 10 }, { text = "AS IF", x = 390, y = 568, width = 21, height = 10 } ]
    , [ { text = "Solitary feather overcome", x = 90, y = 382, width = 94, height = 10 }, { text = "except", x = 291, y = 475, width = 23, height = 10 } ]
    , [ { text = "that the meeting or the touching of a cap at midnight", x = 167, y = 517, width = 192, height = 10 }, { text = "and immobilizes", x = 242, y = 527, width = 60, height = 10 }, { text = "by the velvet crumpled by a dark laughter", x = 214, y = 537, width = 151, height = 10 }, { text = "this rigid whiteness", x = 240, y = 579, width = 71, height = 10 }, { text = "derisory", x = 163, y = 589, width = 30, height = 10 }, { text = "in opposition to the sky", x = 253, y = 610, width = 85, height = 10 }, { text = "too much", x = 189, y = 620, width = 34, height = 10 }, { text = "not to stand out", x = 218, y = 630, width = 57, height = 10 }, { text = "narrowly", x = 256, y = 641, width = 33, height = 10 }, { text = "whoever", x = 269, y = 651, width = 31, height = 10 }, { text = "prince bitter from the danger", x = 256, y = 672, width = 105, height = 10 }, { text = "would cap as the heroic", x = 238, y = 692, width = 87, height = 10 }, { text = "irresistible but content", x = 256, y = 703, width = 82, height = 10 } ]
    , [ { text = "by his small reason virile", x = 244, y = 71, width = 92, height = 10 }, { text = "by lightning", x = 342, y = 82, width = 43, height = 10 }, { text = "anxious", x = 90, y = 454, width = 28, height = 10 }, { text = "expiatory and pubescent", x = 121, y = 465, width = 89, height = 10 }, { text = "silent", x = 240, y = 475, width = 20, height = 10 }, { text = "The lucid and seigniorial plume", x = 207, y = 599, width = 116, height = 10 }, { text = "on the invisible forehead", x = 249, y = 610, width = 90, height = 10 }, { text = "sparkles", x = 227, y = 620, width = 30, height = 10 }, { text = "then shadowing", x = 251, y = 630, width = 57, height = 10 }, { text = "a dark good-looking stature", x = 218, y = 641, width = 102, height = 10 }, { text = "in his twisting of siren", x = 233, y = 651, width = 81, height = 10 }, { text = "by the final impatient scales", x = 209, y = 682, width = 102, height = 10 } ]
    , [ { text = "laughs", x = 209, y = 496, width = 25, height = 10 }, { text = "that", x = 233, y = 517, width = 15, height = 10 }, { text = "IF", x = 247, y = 568, width = 13, height = 17 }, { text = "of dizziness", x = 169, y = 626, width = 42, height = 10 }, { text = "up", x = 172, y = 657, width = 9, height = 10 }, { text = "the time", x = 183, y = 678, width = 29, height = 10 }, { text = "to enkindle", x = 205, y = 688, width = 40, height = 10 }, { text = "bifurcated", x = 172, y = 698, width = 37, height = 10 } ]
    , [ { text = "a rock", x = 196, y = 71, width = 23, height = 10 }, { text = "false mansion", x = 185, y = 92, width = 50, height = 10 }, { text = "immediately", x = 216, y = 103, width = 44, height = 10 }, { text = "evaporated in fog", x = 236, y = 113, width = 64, height = 10 }, { text = "which imposed", x = 225, y = 134, width = 54, height = 10 }, { text = "an edge to infinity", x = 249, y = 144, width = 65, height = 10 }, { text = "IT WAS", x = 458, y = 444, width = 42, height = 17 }, { text = "stemming from stellar", x = 447, y = 460, width = 71, height = 9 }, { text = "IT WOULD BE", x = 90, y = 690, width = 87, height = 17 }, { text = "the worst", x = 135, y = 706, width = 30, height = 9 } ]
    , [ { text = "not", x = 188, y = 72, width = 10, height = 9 }, { text = "more or less", x = 235, y = 81, width = 40, height = 9 }, { text = "but equally as much", x = 310, y = 90, width = 65, height = 9 }, { text = "THE NUMBER", x = 372, y = 458, width = 87, height = 17 }, { text = "IT EXISTED", x = 341, y = 506, width = 48, height = 10 }, { text = "otherwise like a sparse hallucination of agony", x = 320, y = 517, width = 148, height = 9 }, { text = "IT BEGAN AND IT CEASED", x = 288, y = 535, width = 112, height = 10 }, { text = "rising up that denied and closed when it appeared", x = 271, y = 545, width = 160, height = 9 }, { text = "finally", x = 310, y = 555, width = 20, height = 9 }, { text = "by some profusion spread in rarity", x = 294, y = 564, width = 111, height = 9 }, { text = "IT ADDED UP", x = 380, y = 573, width = 56, height = 10 }, { text = "clearly the sum for a little", x = 306, y = 604, width = 83, height = 9 }, { text = "IT ILLUMINATES", x = 359, y = 622, width = 71, height = 10 } ]
    , [ { text = "CHANCE", x = 222, y = 121, width = 148, height = 41 }, { text = "Falls", x = 90, y = 247, width = 43, height = 26 }, { text = "the feather", x = 101, y = 272, width = 94, height = 26 }, { text = "rhythmically suspended from the accident", x = 90, y = 297, width = 371, height = 26 }, { text = "to bury itself", x = 380, y = 322, width = 112, height = 26 }, { text = "in original foams", x = 321, y = 348, width = 151, height = 26 }, { text = "not long ago as far as his frenzy leapt to a top", x = 90, y = 373, width = 402, height = 26 }, { text = "withered", x = 354, y = 398, width = 77, height = 26 }, { text = "by the same neutrality of an abyss", x = 200, y = 424, width = 301, height = 26 }, { text = "NOTHING", x = 181, y = 527, width = 41, height = 10 }, { text = "of the memorable crisis", x = 222, y = 579, width = 86, height = 10 }, { text = "or it was", x = 253, y = 589, width = 32, height = 10 }, { text = "the event", x = 271, y = 599, width = 33, height = 10 } ]
    , [ { text = "carried out with the aim of no useless result", x = 90, y = 620, width = 159, height = 10 }, { text = "human", x = 256, y = 630, width = 24, height = 10 }, { text = "WILL HAVE TAKEN PLACE", x = 194, y = 651, width = 112, height = 10 }, { text = "a common rise toward the absence", x = 181, y = 661, width = 125, height = 10 }, { text = "THAT THE PLACE", x = 278, y = 682, width = 74, height = 10 }, { text = "lapping lower as any to disperse the empty act", x = 90, y = 692, width = 168, height = 10 }, { text = "abruptly as otherwise", x = 200, y = 703, width = 78, height = 10 } ]
    , [ { text = "by his lie", x = 187, y = 71, width = 34, height = 10 }, { text = "had based", x = 207, y = 82, width = 36, height = 10 }, { text = "the perdition", x = 196, y = 92, width = 46, height = 10 }, { text = "in these parts", x = 90, y = 113, width = 48, height = 10 }, { text = "of the wave", x = 143, y = 123, width = 42, height = 10 }, { text = "in which all reality dissolves", x = 183, y = 134, width = 104, height = 10 }, { text = "EXCEPTING", x = 90, y = 517, width = 51, height = 10 }, { text = "at the height", x = 141, y = 527, width = 45, height = 10 }, { text = "PERHAPS", x = 187, y = 537, width = 40, height = 10 }, { text = "so far as a place", x = 229, y = 548, width = 58, height = 10 } ]
    , [ { text = "merges with the beyond", x = 90, y = 568, width = 87, height = 10 }, { text = "except the interest", x = 247, y = 589, width = 66, height = 10 }, { text = "as for him indicated", x = 218, y = 599, width = 73, height = 10 }, { text = "generally", x = 289, y = 610, width = 33, height = 10 }, { text = "to such indirectness by such a slope", x = 90, y = 620, width = 130, height = 10 }, { text = "of lights", x = 225, y = 630, width = 30, height = 10 }, { text = "towards", x = 150, y = 651, width = 29, height = 10 }, { text = "it has to be", x = 176, y = 661, width = 40, height = 10 }, { text = "The Seven Stars also North", x = 214, y = 672, width = 99, height = 10 }, { text = "A CONSTELLATION", x = 297, y = 692, width = 83, height = 10 } ]
    , [ { text = "cold of forgetting and of disuse", x = 214, y = 71, width = 113, height = 10 }, { text = "not so much", x = 302, y = 82, width = 44, height = 10 }, { text = "that it enumerates", x = 289, y = 92, width = 64, height = 10 }, { text = "on some vacant and superior surface", x = 238, y = 103, width = 133, height = 10 }, { text = "the successive clash", x = 291, y = 113, width = 73, height = 10 }, { text = "sidereally", x = 357, y = 123, width = 35, height = 10 }, { text = "of a total count in formation", x = 240, y = 134, width = 102, height = 10 }, { text = "watching over", x = 90, y = 165, width = 52, height = 10 }, { text = "doubting", x = 145, y = 175, width = 33, height = 10 }, { text = "rolling", x = 181, y = 185, width = 24, height = 10 }, { text = "glittering and meditating", x = 203, y = 196, width = 90, height = 10 }, { text = "before it stops itself", x = 256, y = 216, width = 72, height = 10 }, { text = "in some last point which consecrates it", x = 205, y = 227, width = 140, height = 10 }, { text = "Every Thought emits a Roll of the Dice", x = 205, y = 258, width = 143, height = 10 } ]
    ]


pair inputPages =
    let
        bumpRight phrase =
            { phrase | x = phrase.x + 618 - (margin * 2) }
    in
    case inputPages of
        left :: right :: remainder ->
            (left ++ List.map bumpRight right) :: pair remainder

        _ ->
            inputPages


margin =
    90
