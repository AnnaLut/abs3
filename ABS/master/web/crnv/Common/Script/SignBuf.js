//����� ��������� ��� �����. ���
function MakeIntDocBuf(TYPE)
{
	this.TYPE = TYPE;	// ��� ������ ����� (UPB,OSC,NBU)
	this.ND;		    // ����� ���������
	this.DOCD;		  	// ���� ��������� DD.MM.YYYY
	this.VOB;			// ��� ���������
	this.DK;			// ������ �����\������
	this.MFOA;			// ��� ����� �
	this.NLSA;			// ���� �
	this.KVA;			// ������ �
	this.NAMA;			// ������������ �
	this.IDA;			// ���� �
	this.SUMA;			// ����� � (���)
	this.MFOB;			// ��� ����� �
	this.NLSB;			// ���� �
	this.NAMB;			// ������������ B
	this.IDB;			// ���� B
	this.KVB;			// ������ �
	this.SUMB;			// ����� � (���)
	this.NAZN;			// ���������� �������
	
	//��� �����
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