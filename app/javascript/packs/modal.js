export default class Modal {
    constructor(content = "", nameElement = "modal") {
      this.namePlugin = 'modal'
      this.versionPlugin = '';
      this.nameElement = nameElement;
      this.content = content;
      this.html = `
        <div id="${this.nameElement}-${this.namePlugin}-modal" class="${this.namePlugin}-modal">
          <span id="${this.nameElement}-${this.namePlugin}-close" class="${this.namePlugin}-close">X</span>
          <div id="${this.nameElement}-${this.namePlugin}-content" class="${this.namePlugin}-content">${this.content}</div>
        </div>
      `;
      this._render();
      this._closeEvents();
    }
    
    _render() {
      let container = document.createElement('div');
      container.id = `${this.nameElement}-${this.namePlugin}-container`;
      container.className = `${this.namePlugin}-container`;
      let overlay = document.createElement('div');
      overlay.id = `${this.nameElement}-${this.namePlugin}-overlay`;
      overlay.className = `${this.namePlugin}-overlay`;
    //   let calendar = document.createElement('div')
    //   calendar.id = 'calendar'
    //   overlay.appendChild(calendar);
      container.innerHTML = this.html;
      container.appendChild(overlay);
      document.body.appendChild(container);
    }
    
    _closeEvents() {
      document.getElementById(`${this.nameElement}-${this.namePlugin}-close`).addEventListener("click", (e) => { 
        this.close(); 
      });
      document.getElementById(`${this.nameElement}-${this.namePlugin}-overlay`).addEventListener("click", (e) => { 
        this.close(); 
      });
      document.addEventListener("keyup", (e) => { 
        if(e.keyCode == 27 || e.keyCode == 13) {
          this.close();
        }
      });
    }
    
    open() {
      document.getElementById(`${this.nameElement}-${this.namePlugin}-overlay`).style.display = "block";
      document.getElementById(`${this.nameElement}-${this.namePlugin}-modal`).style.display = "block";
    }
    
    close() {
      document.getElementById(`${this.nameElement}-${this.namePlugin}-overlay`).style.display = "none";
      document.getElementById(`${this.nameElement}-${this.namePlugin}-modal`).style.display = "none";
    }
  }
  
  
