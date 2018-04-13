var mess = "Вибачте, але копіювання даного тексту заборонене!";

function rtclickcheck(keyp){
  if (document.layers && keyp.which != 1) {
    alert(mess);
    return false;
  }
  if (document.all && event.button != 1) { 
    alert(mess);
    return false;
  }
}
function sec_mess() {
    alert('УВАГА! Данна дія заборонена!\nВаша спроба скопіювати конфіденційну інформацію була занесена в базу даних!');
    return false;
}
function Block()
{
    document.ondragstart = sec_mess;
    document.onselectstart = sec_mess;
    document.oncontextmenu = sec_mess;    
}
function sec_mess() { return false; }
