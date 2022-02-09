update transaction tr
set past_due_days = current_date - tr.due_date
where lower(tr.loan_status) = 'active'
and tr.paid_off_time is null
returning *
;

select
tr.cust_id
,tr.tenure terms
, tr.eff_date
, tr.due_date
, tr.paid_off_time
, tr.past_due_days days_past_due
from public.transaction tr
;