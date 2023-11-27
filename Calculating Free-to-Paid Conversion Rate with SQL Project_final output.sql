select * from student_engagement;
select * from student_info;
select * from student_purchases;


select
round(count(first_date_purchased)/count(first_date_watched),2) * 100 as conversion_rate,
round(sum(days_diff_reg_watch)/count(days_diff_reg_watch),2) as av_reg_watch,
round(sum(days_diff_watch_purchase)/count(days_diff_watch_purchase),2) as av_watch_purch
from (select
e.student_id, i.date_registered,
min(e.date_watched) as first_date_watched,
min(p.date_purchased) as first_date_purchased,
datediff(MIN(e.date_watched), i.date_registered) AS days_diff_reg_watch,
datediff(min(p.date_purchased), min(e.date_watched)) as days_diff_watch_purchase
from student_engagement e join student_info i
on e.student_id = i.student_id left join 
student_purchases p on e.student_id = p.student_id
group by e.student_id
having first_date_watched <= first_date_purchased) a;