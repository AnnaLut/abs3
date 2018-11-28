using Areas.EDeclarations.Models;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Core.Models;
using System;
using System.Collections.Generic;

namespace BarsWeb.Areas.EDeclarations.Infrastructure.DI.Abstract
{
    public interface IEDeclarationsRepository
    {
        IEnumerable<T> SearchGlobal<T>(DataSourceRequest request, BarsSql searchQuery);
        decimal CountGlobal(DataSourceRequest request, BarsSql searchQuery);
        IEnumerable<T> ExecuteStoreQuery<T>(BarsSql searchQuery);
        int ExecuteStoreCommand(string commandText, params object[] parameters);
        Params GetParam(string id);

        /// <summary>
        /// ������������ ������� �� ����� ������ ��� �-����������
        /// </summary>
        /// <param name="sql"></param>
        /// <returns></returns>
        Int32 CreateRequest(BarsSql sql);

        /// <summary>
        /// ����� ���������� �� ��
        /// </summary>
        /// <param name="sql"></param>
        /// <returns></returns>
        Int32 SearchDeclaration(BarsSql sql);

        /// <summary>
        /// ��������� PDF ����� �� ��
        /// </summary>
        /// <param name="sql"></param>
        /// <returns></returns>
        Byte[] GetDeclarationFile(BarsSql sql);
    }
}