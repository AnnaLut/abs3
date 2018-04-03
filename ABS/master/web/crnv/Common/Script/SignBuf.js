//Буфер документа для внутр. ЭЦП
function MakeIntDocBuf(TYPE)
{
	this.TYPE = TYPE;	// для какого банка (UPB,OSC,NBU)
	this.ND;		    // номер документа
	this.DOCD;		  	// дата документа DD.MM.YYYY
	this.VOB;			// вид документа
	this.DK;			// символ Дебет\Кредит
	this.MFOA;			// МФО банка А
	this.NLSA;			// счет А
	this.KVA;			// валюта А
	this.NAMA;			// наименование А
	this.IDA;			// окпо А
	this.SUMA;			// сумма А (коп)
	this.MFOB;			// МФО банка Б
	this.NLSB;			// счет Б
	this.NAMB;			// наименование B
	this.IDB;			// окпо B
	this.KVB;			// валюта Б
	this.SUMB;			// сумма Б (коп)
	this.NAZN;			// назначения платежа
	
	//сам буферё
	this.getIntBuf = function()
	{
		var buf = '';
		switch(this.TYPE)
		{
			case 'UPB' : buf =  padr(this.ND,10)+
								this.DOCD.substring(8,10)+this.DOCD.substring(3,5)+this.DOCD.substring(0,2)+
								padl(this.VOB,6)+
								this.DK+
								padl(this.MFOA,9)+
								padl(this.NLSA,14)+
								padl(this.KVA,3)+
								padl(this.SUMA.toString(10),16)+
								padl(this.MFOB,9)+
								padl(this.NLSB,14)+
								padl(this.KVB,3)+
								padl(this.SUMB.toString(10),16)+
								padr(this.NAZN,160);
						 break;
			case 'OSC' : buf =  padr(this.ND,10)+
								this.DOCD.substring(8,10)+this.DOCD.substring(3,5)+this.DOCD.substring(0,2)+
								this.DK+
								padl(this.MFOA,9)+
								padl(this.NLSA,14)+
								padl(this.KVA,3)+
								padl(this.SUMA.toString(10),16)+
								padr(this.NAMA,38)+
								padl(this.IDA,14)+
								padl(this.MFOB,9)+
								padl(this.NLSB,14)+
								padl(this.KVB,3)+
								padl(this.SUMB.toString(10),16)+
								padr(this.NAMB,38)+
								padl(this.IDB,14)+
								padr(this.NAZN,160);
						 break;				 
			case 'NBU' : buf =  padr(this.ND,10)+
								this.DOCD.substring(8,10)+this.DOCD.substring(3,5)+this.DOCD.substring(0,2)+
								this.DK+
								padl(this.MFOA,9)+
								padl(this.NLSA,14)+
								padl(this.KVA,3)+
								padl(this.SUMA.toString(10),16)+
								padl(this.MFOB,9)+
								padl(this.NLSB,14)+
								padl(this.KVB,3)+
								padl(this.SUMB.toString(10),16);
						 break;
			default	   : buf =  padr(this.ND,10)+
								this.DOCD.substring(8,10)+this.DOCD.substring(3,5)+this.DOCD.substring(0,2)+
								this.DK+
								padl(this.MFOA,9)+
								padl(this.NLSA,14)+
								padl(this.KVA,3)+
								padl(this.SUMA.toString(10),16)+
								padr(this.NAMA,38)+
								padl(this.IDA,14)+
								padl(this.MFOB,9)+
								padl(this.NLSB,14)+
								padl(this.KVB,3)+
								padl(this.SUMB.toString(10),16)+
								padr(this.NAMB,38)+
								padl(this.IDB,14)+
								padr(this.NAZN,160);
						 break;			 
		}
		return buf;
	}
}