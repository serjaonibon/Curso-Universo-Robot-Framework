import psycopg2

db_conn = """
    host='ep-solitary-math-a8s09yzc-pooler.eastus2.azure.neon.tech'
    dbname='smartbit'
    user='smartbit_owner'
    password='npg_eMSXd9avorb7'
"""

def execute(query):
    conn = psycopg2.connect(db_conn)
    
    cur = conn.cursor()
    cur.execute(query)
    conn.commit()
    conn.close()
    
def insert_membership(data):
    account = data["account"]
    plan = data["plan"]
    credit_card = data["credit_card"]["number"][-4]
    
    
    query = f"""    
    BEGIN; -- Inicia uma transação

    -- Remove o registro pelo email
    DELETE FROM accounts
    WHERE email = '{account["email"]}';

    -- Insere uma nova conta e obtém o ID da conta recém-inserida
    WITH new_account AS (
        INSERT INTO accounts (name, email, cpf)
        VALUES ('{account["name"]}', '{account["email"]}', '{account["cpf"]}')
        RETURNING id
    )

    -- Insere um registro na tabela memberships com o ID da conta
    INSERT INTO memberships (account_id, plan_id, credit_card, price, status)
    SELECT id, {plan["id"]}, '{credit_card}', {plan["price"]}, true
    FROM new_account;

    COMMIT; -- Confirma a transação    
    """
    execute(query)
    

def insert_account(account):
        query = f"""
        insert into accounts ("name" , email, cpf) 
        values ('{account["name"]}', '{account["email"]}', '{account["cpf"]}' );
        """
        execute(query)
      

def delete_account_by_email(email):
    query = f"delete from accounts where email = '{email}' ;"
    execute(query)