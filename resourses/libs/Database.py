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
    

def insert_account(account):
        query = f"""
        insert into accounts ("name" , email, cpf) 
        values ('{account["name"]}', '{account["email"]}', '{account["cpf"]}' );
        """
        execute(query)
      

def delete_account_by_email(email):
    query = f"delete from accounts where email = '{email}' ;"
    execute(query)