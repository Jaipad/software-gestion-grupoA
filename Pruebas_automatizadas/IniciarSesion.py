from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
import tempfile
import shutil
import time

options = webdriver.ChromeOptions()
options.add_argument("--start-maximized")
options.add_argument("--headless=new")  # modo headless para evitar problemas en CI
options.add_argument("--disable-gpu")

temp_profile = tempfile.mkdtemp()
options.add_argument(f"--user-data-dir={temp_profile}")

driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()), options=options)

try:
    driver.get("http://localhost:3004/")
    time.sleep(1)
    driver.get("http://localhost:3004/login")
    time.sleep(1)

    email_input = driver.find_element(By.NAME, "email")
    email_input.send_keys("admin1@uach.cl")

    password_input = driver.find_element(By.NAME, "password")
    password_input.send_keys("ADMIN123")

    login_button = driver.find_element(By.XPATH, "//button[contains(text(), 'Login')]")
    login_button.click()

    time.sleep(3)

    print("✅ Prueba de login completada")
except Exception as e:
    print(f"❌ Error en la prueba: {e}")
finally:
    driver.quit()
    shutil.rmtree(temp_profile)
