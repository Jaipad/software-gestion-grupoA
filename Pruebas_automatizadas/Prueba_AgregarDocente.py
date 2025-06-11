from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.alert import Alert
import tempfile
import shutil
import time

options = webdriver.ChromeOptions()
options.add_argument("--start-maximized")
options.add_argument("--headless=new")  # Ejecutar sin UI
options.add_argument("--disable-gpu")

# Crear directorio temporal para el perfil del navegador
temp_profile = tempfile.mkdtemp()
options.add_argument(f"--user-data-dir={temp_profile}")

driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()), options=options)

try:
    # 1. Iniciar sesión como director
    driver.get("http://localhost:3004/login")
    time.sleep(1)
    driver.find_element(By.NAME, "email").send_keys("admin@uach.cl")
    driver.find_element(By.NAME, "password").send_keys("ADMIN123")
    driver.find_element(By.XPATH, "//button[contains(text(), 'Login')]").click()
    time.sleep(2)

    # 2. Navegar a la sección de administración de profesores
    driver.get("http://localhost:3004/docentes")
    time.sleep(2)

    # 3. Seleccionar la opción para agregar un nuevo profesor
    driver.find_element(By.XPATH, "//button[contains(text(), 'Agregar Docente')]").click()
    time.sleep(1)

    # Esperar que el modal sea visible
    WebDriverWait(driver, 10).until(
        EC.visibility_of_element_located((By.XPATH, "//div[contains(@class, 'estilos_modal')]"))
    )

    # 4. Completar el formulario con datos válidos
    driver.find_element(By.XPATH, "//input[@placeholder='Nombre']").send_keys("Cristian")
    driver.find_element(By.XPATH, "//input[@placeholder='Apellido']").send_keys("Pérez")
    driver.find_element(By.XPATH, "//input[@placeholder='Email']").send_keys("cristian.perez@uach.cl")
    driver.find_element(By.XPATH, "//input[@placeholder='Teléfono']").send_keys("987633321")
    driver.find_element(By.XPATH, "//input[@placeholder='Créditos Máximos']").send_keys("20")
    driver.find_element(By.XPATH, "//input[@placeholder='RUT (formato: 12345678-9)']").send_keys("14253332-6")
    driver.find_element(By.XPATH, "//input[@placeholder='Contraseña']").send_keys("CristianRun")

    # 5. Seleccionar el tipo de contrato
    driver.find_element(By.XPATH, "//select[@name='contract']").send_keys("ACA")

    time.sleep(1)
    
    # 6. Agregamos
    driver.find_element(By.XPATH, "//button[@type='submit' and contains(text(), 'Agregar')]").click()
    time.sleep(5)

    # 7. Manejar la alerta de confirmación
    WebDriverWait(driver, 10).until(EC.alert_is_present())
    alert = Alert(driver)
    alert.accept()
    print("✅ Confirmación de docente agregado")
    time.sleep(3)

    # Verificar mensajes de error por datos inválidos
    errores = driver.find_elements(By.XPATH, "//div[contains(@class, 'error-message')]")
    assert len(errores) > 0, "Error: No se mostraron mensajes de validación para datos incorrectos"

    print("✅ Todas las pruebas se ejecutaron correctamente")

except Exception as e:
    print(f"❌ Error en la prueba: {e}")

finally:
    driver.quit()
    shutil.rmtree(temp_profile)
