import { Elm } from './Main.elm'
import 'elm-pep'

const app = Elm.Main.init({
  node: document.querySelector('main'),
  flags: {
    devicePixelRatio: window.devicePixelRatio,
    screenDimensions: [window.innerWidth, window.innerHeight],
  },
})
