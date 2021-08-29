const { app, BrowserWindow } = require('electron');

function createWindow () {
    const win = new BrowserWindow({
      width: 800,
      height: 600
    });
    let url;
    if (process.env.NODE_ENV === 'DEV') {
        url = 'http://localhost:8080/'
      } else {
        url = `file://${process.cwd()}/dist/index.html`
      }
      win.loadURL(url);
  }

  app.whenReady().then(() => {
    createWindow()
    
  });

  app.on('window-all-closed', function () {
    if (process.platform !== 'darwin') app.quit()
  });