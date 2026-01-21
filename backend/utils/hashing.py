import bcrypt


def hash_password(plain_password: str) -> str:
    """Hash a plain text password using bcrypt."""



    # Generate a salt for the hash
    salt: bytes = bcrypt.gensalt()
    # Hash the password
    hashed_password: bytes = bcrypt.hashpw(plain_password.encode('utf-8'), salt)
    return hashed_password.decode('utf-8')
    

def verify_password(plain_password: str, hashed_password: str) -> bool:
    """Verify a plain text password against a hashed password using bcrypt."""

    # Encode the given password to bytes
    password_claim: bytes = plain_password.encode('utf-8')
    
    # Encode the stored hashed password to bytes
    stored_hash: bytes = hashed_password.encode('utf-8')

    # Verify the password
    return bcrypt.checkpw(password_claim, stored_hash)

    
    