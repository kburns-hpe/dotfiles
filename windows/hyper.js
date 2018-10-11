// Future versions of Hyper may add additional config options,
// which will not automatically be merged into this file.
// See https://hyper.is#cfg for all currently supported options.

const black = '#000000';
const red = '#ff2600';
const green = '#3AD900';
const yellow = '#ffc600';
const blue = '#1478DB';
const magenta = '#ff2c70';
const cyan = '#00c5c7';
const white = '#ffffff';
const lightBlack = '#808080';
const lightRed = '#ff0000';
const lightGreen = '#33ff00';
const lightYellow = '#ffff00';
const lightBlue = '#1478DB';
const lightMagenta = '#cc00ff';
const lightCyan = '#00ffff';
const lightWhite = '#ffffff';

// custom colours
const cobalt2blue = '#193549';
const variableBlue = '#0d3a58';
const dustyBlue = '#34424C';
const highlightBlue = '#1F4662';

module.exports = {
  config: {
    // choose either `'stable'` for receiving highly polished,
    // or `'canary'` for less polished but more frequent updates
    updateChannel: 'stable',

    // default font size in pixels for all tabs
    fontSize: 16,

    // font family with optional fallbacks
    fontFamily: '"DejaVu Sans Mono For Powerline", "DejaVu Sans Mono", Consolas, "Lucida Console", monospace',

    // default font weight: 'normal' or 'bold'
    fontWeight: 'normal',

    // font weight for bold characters: 'normal' or 'bold'
    fontWeightBold: 'bold',

    // terminal cursor background color and opacity (hex, rgb, hsl, hsv, hwb or cmyk)
    cursorColor: yellow,

    // terminal text color under BLOCK cursor
    cursorAccentColor: '#000',

    // omit or set true to show. set false to remove it
    wickedBorder: false,
    // change the colour here
    wickedBorderColor: 'rgba(255,255,255,0.1)',

    // `'BEAM'` for |, `'UNDERLINE'` for _, `'BLOCK'` for █
    cursorShape: 'BLOCK',

    // set to `true` (without backticks and without quotes) for blinking cursor
    cursorBlink: false,

    // color of the text
    foregroundColor: white,

    // terminal background color
    // opacity is only supported on macOS
    backgroundColor: cobalt2blue,

    // terminal selection color
    selectionColor: 'rgba(255,198,0, 0.5)',

    // border color (window, tabs)
    borderColor: 'rgba(255,255,255,0.1)',

    // custom CSS to embed in the main window
    css: `
    .tab_active {
      background: rgba(255,255,255,0.05);
      border-bottom: 1px solid ${yellow} !important;
      border-color: ${yellow};
    }
    .tabs_nav {
      border-bottom: 1px solid rgba(255,255,255,0.1)  !important;
    }
  `,
    // custom CSS to embed in the terminal window
    termCSS: '',

    // if you're using a Linux setup which show native menus, set to false
    // default: `true` on Linux, `true` on Windows, ignored on macOS
    showHamburgerMenu: '',

    // set to `false` (without backticks and without quotes) if you want to hide the minimize, maximize and close buttons
    // additionally, set to `'left'` if you want them on the left, like in Ubuntu
    // default: `true` (without backticks and without quotes) on Windows and Linux, ignored on macOS
    showWindowControls: '',

    // custom padding (CSS format, i.e.: `top right bottom left`)
    padding: '12px 14px',

    // the full list. if you're going to provide the full color palette,
    // including the 6 x 6 color cubes and the grayscale map, just provide
    // an array here instead of a color map object
    colors: {
      black,
      red,
      green,
      yellow,
      blue,
      magenta,
      cyan,
      white,
      lightBlack,
      lightRed,
      lightGreen,
      lightYellow,
      lightBlue,
      lightMagenta,
      lightCyan,
      lightWhite
    },

    // the shell to run when spawning a new session (i.e. /usr/local/bin/fish)
    // if left empty, your system's login shell will be used by default
    //
    // Windows
    // - Make sure to use a full path if the binary name doesn't work
    // - Remove `--login` in shellArgs
    //
    // Bash on Windows
    // - Example: `C:\\Windows\\System32\\bash.exe`
    //
    // PowerShell on Windows
    // - Example: `C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe`
    shell: 'C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe',
    // shell: 'C:\\Windows\\System32\\bash.exe',

    // for setting shell arguments (i.e. for using interactive shellArgs: `['-i']`)
    // by default `['--login']` will be used
    shellArgs: [],

    // for environment variables
    env: {},

    // set to `false` for no bell
    bell: 'false',

    // if `true` (without backticks and without quotes), selected text will automatically be copied to the clipboard
    copyOnSelect: false,

    // if `true` (without backticks and without quotes), hyper will be set as the default protocol client for SSH
    defaultSSHApp: true,

    // if `true` (without backticks and without quotes), on right click selected text will be copied or pasted if no
    // selection is present (`true` by default on Windows and disables the context menu feature)
    // quickEdit: true,

    // URL to custom bell
    // bellSoundURL: 'http://example.com/bell.mp3',

    // for advanced config flags please refer to https://hyper.is/#cfg
  },

  // a list of plugins to fetch and install from npm
  // format: [@org/]project[#version]
  // examples:
  //   `hyperpower`
  //   `@company/project`
  //   `project#1.0.1`
  plugins: [ ],

  // in development, you can create a directory under
  // `~/.hyper_plugins/local/` and include it here
  // to load it and avoid it being `npm install`ed
  localPlugins: [],

  keymaps: {
    // Example
    // 'window:devtools': 'cmd+alt+o',
  },
};
