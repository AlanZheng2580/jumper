
from __future__ import annotations

import pendulum

from airflow.models.dag import DAG
from airflow.operators.bash import BashOperator

with DAG(
    dag_id="example_bash_operator",
    schedule=None,
    start_date=pendulum.datetime(2023, 1, 1, tz="UTC"),
    catchup=False,
    tags=["example"],
) as dag:
    run_this = BashOperator(
        task_id="run_this",
        bash_command="echo 'This is a test DAG from the jumper setup!'",
    )
