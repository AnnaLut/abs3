create or replace procedure p_fm_set_params (
  p_id    finmon_que.id%type,
  p_ref   finmon_que.ref%type,
  p_rec   finmon_que.rec%type,
  p_vid1  finmon_que.opr_vid1%type,
  p_vid2  finmon_que.opr_vid2%type,
  p_comm2 finmon_que.comm_vid2%type,
  p_vid3  finmon_que.opr_vid3%type,
  p_comm3 finmon_que.comm_vid3%type,
  p_mode  finmon_que.monitor_mode%type,
  p_rnka  finmon_que.rnk_a%type,
  p_rnkb  finmon_que.rnk_b%type )
as
begin

  if p_id is null then

     insert into finmon_que(ref, rec, status, opr_vid1, opr_vid2, comm_vid2, opr_vid3, comm_vid3, monitor_mode, agent_id, rnk_a, rnk_b)
     values (p_ref, p_rec, 'I', nvl(p_vid1,'999999999999999'), p_vid2, p_comm2, p_vid3, p_comm3, p_mode, user_id, p_rnka, p_rnkb);

  else

     update finmon_que
        set opr_vid1 = nvl(p_vid1,'999999999999999'),
            opr_vid2 = p_vid2,
            comm_vid2 = p_comm2,
            opr_vid3  = p_vid3,
            comm_vid3 = p_comm3,
            monitor_mode = p_mode,
            status = decode(status,'R','I',status),
            rnk_a = p_rnka,
            rnk_b = p_rnkb
      where id = p_id;

     if p_vid2 = '0000' then
        delete from finmon_que_vid2 where id = p_id;
     end if;
     if p_vid3 = '000' then
        delete from finmon_que_vid3 where id = p_id;
     end if;

  end if;

end p_fm_set_params;
/
