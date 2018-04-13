using System;
using System.IO;
using System.Text;

public class CRC
{
    byte[] data = new byte[0];
    uint Crc = unchecked(0xFFFFFFFF);
    //-----------------------------------
    public CRC(string fPath, string firstFName)
	{
        int step = 1024;

        byte[] tmp1 = new byte[step];
        byte[] tmp2 = new byte[step];

        FileStream fileStream = new FileStream(fPath, FileMode.Open, FileAccess.Read);
        int count = -1;
        while (count != 0)
        {
            tmp1 = (byte[])this.data.Clone();
            count = fileStream.Read(tmp2, 0, step);

            this.data = ConCat(tmp1, tmp1.Length, tmp2, count);
        }
        fileStream.Close();

        tmp1 = this.data;
        tmp2 = (new UnicodeEncoding()).GetBytes(firstFName);
        this.data = ConCat(tmp1, tmp1.Length, tmp2, tmp2.Length);

        Crc = CalculateCrc(Crc, this.data, 0, this.data.Length);
	}
    public string GetCrc()
    {
        return (unchecked(Crc ^ 0xFFFFFFFF)).ToString("X8");
    }
    //-----------------------------------
    private static uint[] table = GenerateTable();
    private byte[] ConCat(byte[] a, long aLng, byte[] b, long bLng)
    {
        byte[] res = new byte[aLng + bLng];

        for (int i = 0; i < aLng; i++) res[i] = a[i];
        for (int i = 0; i < bLng; i++) res[i + aLng] = b[i];

        return res;
    }
    private uint CalculateCrc(uint crc, byte[] buffer, int offset, int count)
    {
        unchecked
        {
            for (int i = offset, end = offset + count; i < end; i++)
                crc = (crc >> 8) ^ table[(crc ^ buffer[i]) & 0xFF];
        }
        return crc;
    }
    private static uint[] GenerateTable()
    {
        unchecked
        {
            uint[] table = new uint[256];

            uint crc;
            const uint poly = 0xEDB88320;
            for (uint i = 0; i < table.Length; i++)
            {
                crc = i;
                for (int j = 8; j > 0; j--)
                {
                    if ((crc & 1) == 1)
                        crc = (crc >> 1) ^ poly;
                    else
                        crc >>= 1;
                }
                table[i] = crc;
            }

            return table;
        }
    }
}
