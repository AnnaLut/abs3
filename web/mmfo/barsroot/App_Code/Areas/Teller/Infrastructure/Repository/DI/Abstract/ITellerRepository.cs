using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.Teller.Enums;
using BarsWeb.Areas.Teller.Model;
using BarsWeb.Core.Models;
using System;
using System.Collections.Generic;

namespace BarsWeb.Areas.Teller.Infrastructure.DI.Abstract
{
    public interface ITellerRepository
    {
        /// <summary>
        /// ���������, ����������� �������
        /// </summary>
        /// <param name="isTeller"></param>
        void SetTeller(bool isTeller);

        /// <summary>
        /// �������� �����
        /// </summary>
        /// <param name="sum"></param>
        /// <returns></returns>
        int CheckSmall(decimal sum);

        /// <summary>
        /// ���������� �������� ��������� � ���������� ������� ���� ��� � ��� ����������
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        TellerWindowStatusModel ExecuteGetStatus(ATMModel data);

        /// <summary>
        /// ���������� �������� ��������� TechnicalButtonSubmit, CheckVisaDocs, CheckStornoDocs
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        TellerResponseModel DocsAndTechnical(TellerRequestModel data);

        /// <summary>
        /// ��������� ������ ����������� ������ � sql ����� ��������
        /// </summary>
        /// <returns></returns>
        List<ATMTechnicalButtonsModel> GetTechnicalButtons();

        /// <summary>
        /// ��������� ��������� �������
        /// </summary>
        /// <returns></returns>
        TellerStatus GetTellerStatus();

        /// <summary>
        /// ��������� ������� ��� ����������� ��� ������� ������ ������� (���� ������������ � Documents.aspx, Docinput.aspx)
        /// </summary>
        /// <returns></returns>
        Int32 IsButtonVisible();

        TellerResponseModel ChangeRequest(TellerWindowStatusModel data);

        /// <summary>
        /// ������� ����������
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        TellerResponseModel Encashment(EncashmentModel data);

        /// <summary>
        /// ��������� ������ �����
        /// </summary>
        /// <returns></returns>
        IEnumerable<TellerCurrency> GetCurrencyList();

        /// <summary>
        /// ��������� ��������� � �� ���������� ������������ ������
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        IEnumerable<ATMCurrencyListModel> GetAtmCurrencyList(String code);

        /// <summary>
        /// �������� ������ ��������� � �� ���������� ��� ����������� ���������� �������� ��������������
        /// </summary>
        /// <param name="xml"></param>
        /// <param name="currency"></param>
        /// <returns></returns>
        TellerResponseModel CollectPartial(String xml, String currency);

        /// <summary>
        /// ��������� ������� ��� ��� ����������� ����������� �� ������������� ������� ����� �� ���
        /// </summary>
        /// <returns></returns>
        TellerStatusModel TellerStatus(Boolean http);

        /// <summary>
        /// ��������� ������ ����������� ��� ���������� �������� ���������� ����� ���
        /// </summary>
        /// <returns></returns>
        List<TellerEncashmentList> EncashmentList();

        /// <summary>
        /// ������������� ���������� �������� ����� ���
        /// </summary>
        /// <param name="docRef"></param>
        /// <returns></returns>
        Int32 ConfirmTox(ConfirmTox tox);

        /// <summary>
        /// ��������� ���� ���� �������:
        ///     ����������
        ///     ������
        ///     ��� ����
        /// </summary>
        /// <returns></returns>
        TellerCurrentRole GetRole();

        /// <summary>
        /// ��������� ������� ����� � ����������
        /// </summary>
        /// <returns></returns>
        String GetEncashmentNonAmount(String cur_code);

        /// <summary>
        /// ��������� ���� ������ �� ��������
        /// </summary>
        /// <param name="currency"></param>
        /// <returns></returns>
        String GetCurrencyCode(String currency);

        /// <summary>
        /// ��������� ������ ����� � �� ���������� � ����������
        /// ������������ ��� ������� �������
        /// </summary>
        /// <returns></returns>
        List<NonAtmAmount> nonAtmAmount();

        /// <summary>
        /// �������� �� ������������� �������� (��� ������� �� ���������� ����������)
        /// </summary>
        /// <param name="operation">
        /// I - ������������� �������� �� �������� ��������
        /// O - ������������� �������� �� ������ ��������
        /// </param>
        /// <returns></returns>
        Boolean IfAllowedEncashment(String operation);

        void CreateCollectOpper();

        /// <summary>
        /// �������� �������� ���������� ����� ��� (������ ��� ������������� � ���� ����������)
        /// </summary>
        /// <param name="id">�� ��������</param>
        /// <returns></returns>
        TellerResponseModel RemoveOper(Int32 id);

        /// <summary>
        /// ������������� ��������
        /// </summary>
        /// <param name="docRef"></param>
        /// <returns></returns>
        TellerResponseModel Storno(Decimal docRef);

        /// <summary>
        /// ��������� ������� ��� ����������� �������
        /// </summary>
        /// <returns></returns>
        TellerResponseModel CheckTellerStatus();

        /// <summary>
        /// ��������� ���������� ����
        /// </summary>
        /// <returns></returns>
        String GetBankDate();

        /// <summary>
        /// ��������� �������� ��� ����������� ������ "������" �� ����� ���������
        /// 1 - ����������
        /// 0 - ������
        /// </summary>
        /// <returns></returns>
        Int32 GetToxFlag();   
    }
}