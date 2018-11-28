prompt fill table STO_TTS
insert /*+ ignore_row_on_dupkey_index(STO_TTS XPK_STO_TTS)*/ into sto_tts (tt, name)
select tt, name from bars.tts where tt = 'PKD';
insert /*+ ignore_row_on_dupkey_index(STO_TTS XPK_STO_TTS)*/ into sto_tts (tt, name)
select tt, name from bars.tts where tt = '310';
insert /*+ ignore_row_on_dupkey_index(STO_TTS XPK_STO_TTS)*/ into sto_tts (tt, name)
select tt, name from bars.tts where tt = '101';
insert /*+ ignore_row_on_dupkey_index(STO_TTS XPK_STO_TTS)*/ into sto_tts (tt, name)
select tt, name from bars.tts where tt = 'D66';
insert /*+ ignore_row_on_dupkey_index(STO_TTS XPK_STO_TTS)*/ into sto_tts (tt, name)
select tt, name from bars.tts where tt = 'PKR';
insert /*+ ignore_row_on_dupkey_index(STO_TTS XPK_STO_TTS)*/ into sto_tts (tt, name)
select tt, name from bars.tts where tt = '440';
insert /*+ ignore_row_on_dupkey_index(STO_TTS XPK_STO_TTS)*/ into sto_tts (tt, name)
select tt, name from bars.tts where tt = '420';
insert /*+ ignore_row_on_dupkey_index(STO_TTS XPK_STO_TTS)*/ into sto_tts (tt, name)
select tt, name from bars.tts where tt = '445';
insert /*+ ignore_row_on_dupkey_index(STO_TTS XPK_STO_TTS)*/ into sto_tts (tt, name)
select tt, name from bars.tts where tt = 'K20';
insert /*+ ignore_row_on_dupkey_index(STO_TTS XPK_STO_TTS)*/ into sto_tts (tt, name)
select tt, name from bars.tts where tt = 'M19';
insert /*+ ignore_row_on_dupkey_index(STO_TTS XPK_STO_TTS)*/ into sto_tts (tt, name)
select tt, name from bars.tts where tt = '190';
insert /*+ ignore_row_on_dupkey_index(STO_TTS XPK_STO_TTS)*/ into sto_tts (tt, name)
select tt, name from bars.tts where tt = 'PKQ';
insert /*+ ignore_row_on_dupkey_index(STO_TTS XPK_STO_TTS)*/ into sto_tts (tt, name)
select tt, name from bars.tts where tt = 'W4W';
insert /*+ ignore_row_on_dupkey_index(STO_TTS XPK_STO_TTS)*/ into sto_tts (tt, name)
select tt, name from bars.tts where tt = 'PK!';
insert /*+ ignore_row_on_dupkey_index(STO_TTS XPK_STO_TTS)*/ into sto_tts (tt, name)
select tt, name from bars.tts where tt = 'W4T';
insert /*+ ignore_row_on_dupkey_index(STO_TTS XPK_STO_TTS)*/ into sto_tts (tt, name)
select tt, name from bars.tts where tt = 'DOR';
insert /*+ ignore_row_on_dupkey_index(STO_TTS XPK_STO_TTS)*/ into sto_tts (tt, name)
select tt, name from bars.tts where tt = 'PS1';
insert /*+ ignore_row_on_dupkey_index(STO_TTS XPK_STO_TTS)*/ into sto_tts (tt, name)
select tt, name from bars.tts where tt = 'PS2';
commit;
