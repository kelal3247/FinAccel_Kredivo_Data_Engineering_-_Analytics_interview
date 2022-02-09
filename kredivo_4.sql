select
tr.cust_id
, sum(tr.amount) total_loan_amt
, min(tr.eff_date) first_trx_date
, max(tr.eff_date) first_trx_date
, min(tr.due_date) first_due_date
, max(tr.due_date) last_due_date
, tr.paid_off_time
, tr.tenure fav_terms
from public.transaction tr
group by
tr.cust_id
, tr.paid_off_time
, tr.tenure
;