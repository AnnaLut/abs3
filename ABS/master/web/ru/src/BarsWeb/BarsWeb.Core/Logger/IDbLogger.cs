using System;

namespace BarsWeb.Core.Logger
{
    public interface IDbLogger
    {
        /// <summary>
        /// ����� � ���� �����������
        /// </summary>
        /// <param name="messageText">����� �����������</param>
        /// <returns>����� ������ � ���</returns>
        decimal Trace(string messageText);

        /// <summary>
        /// ����� � ���� �����������
        /// </summary>
        /// <param name="messageText">����� �����������</param>
        /// <param name="moduleName">������</param>
        /// <returns>����� ������ � ���</returns>
        decimal Trace(string messageText, string moduleName);

        /// <summary>
        /// ����� � ���� �����������
        /// </summary>
        /// <param name="messageText">����� �����������</param>
        /// <returns>����� ������ � ���</returns>
        decimal Debug(string messageText);

        /// <summary>
        /// ����� � ���� �����������
        /// </summary>
        /// <param name="messageText">����� �����������</param>
        /// <param name="moduleName">������</param>
        /// <returns>����� ������ � ���</returns>
        decimal Debug(string messageText, string moduleName);

        /// <summary>
        /// ����� � ���� �����������
        /// </summary>
        /// <param name="messageText">����� �����������</param>
        /// <returns>����� ������ � ���</returns>
        decimal Info(string messageText);

        /// <summary>
        /// ����� � ���� �����������
        /// </summary>
        /// <param name="messageText">����� �����������</param>
        /// <param name="moduleName">������</param>
        /// <returns>����� ������ � ���</returns>
        decimal Info(string messageText, string moduleName);

        /// <summary>
        /// ����� � ���� �����������
        /// </summary>
        /// <param name="messageText">����� �����������</param>
        /// <returns>����� ������ � ���</returns>
        decimal Security(string messageText);

        /// <summary>
        /// ����� � ���� �����������
        /// </summary>
        /// <param name="messageText">����� �����������</param>
        /// <param name="moduleName">������</param>
        /// <returns>����� ������ � ���</returns>
        decimal Security(string messageText, string moduleName);

        /// <summary>
        /// ����� � ���� �����������
        /// </summary>
        /// <param name="messageText">����� �����������</param>
        /// <returns>����� ������ � ���</returns>
        decimal Financial(string messageText);

        /// <summary>
        /// ����� � ���� �����������
        /// </summary>
        /// <param name="messageText">����� �����������</param>
        /// <param name="moduleName">������</param>
        /// <returns>����� ������ � ���</returns>
        decimal Financial(string messageText, string moduleName);

        /// <summary>
        /// ����� � ���� �����������
        /// </summary>
        /// <param name="messageText">����� �����������</param>
        /// <returns>����� ������ � ���</returns>
        decimal Warning(string messageText);

        /// <summary>
        /// ����� � ���� �����������
        /// </summary>
        /// <param name="messageText">����� �����������</param>
        /// <param name="moduleName">������</param>
        /// <returns>����� ������ � ���</returns>
        decimal Warning(string messageText, string moduleName);

        /// <summary>
        /// ����� � ���� �����������
        /// </summary>
        /// <param name="messageText">����� �����������</param>
        /// <returns>����� ������ � ���</returns>
        decimal Error(string messageText);

        /// <summary>
        /// ����� � ���� �����������
        /// </summary>
        /// <param name="messageText">����� �����������</param>
        /// <param name="moduleName">������</param>
        /// <returns>����� ������ � ���</returns>
        decimal Error(string messageText, string moduleName);

        /// <summary>
        /// ����� � ���� �����������
        /// </summary>
        /// <param name="messageText">����� �����������</param>
        /// <returns>����� ������ � ���</returns>
        decimal Fatal(string messageText);

        /// <summary>
        /// ����� � ���� �����������
        /// </summary>
        /// <param name="messageText">����� �����������</param>
        /// <param name="moduleName">������</param>
        /// <returns>����� ������ � ���</returns>
        decimal Fatal(string messageText, string moduleName);
        /// <summary>
        /// ����� � ���� ����������
        /// ��� �������
        /// </summary>
        /// <param name="e">�������</param>
        /// <returns>����� ������ � ���</returns>
        decimal Exception(Exception e);

    }
}