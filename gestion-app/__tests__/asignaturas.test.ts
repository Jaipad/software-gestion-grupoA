import { GET as getAsignaturas, POST as postAsignatura, DELETE as deleteAsignatura } from '../app/api/asignaturas/route';
import { NextRequest } from 'next/server';

describe('API - Asignaturas', () => {
  it('GET /api/asignaturas debe retornar asignaturas', async () => {
    const res = await getAsignaturas();
    const data = await res.json();
    expect(Array.isArray(data)).toBe(true);
    expect(data.length).toBeGreaterThan(0);
    expect(data[0]).toHaveProperty('course_name');
  });

  it('POST /api/asignaturas debe insertar una nueva asignatura', async () => {
    const body = {
      course_name: 'TEST - ESTRUCTURAS AVANZADAS',
      code: 'TEST999',
      credits: 4,
      semester_id: 38,
    };

    const req = new NextRequest('http://localhost/api/asignaturas', {
      method: 'POST',
      body: JSON.stringify(body),
      headers: { 'Content-Type': 'application/json' },
    });

    const res = await postAsignatura(req);
    const data = await res.json();
    expect(res.status).toBe(201);
    expect(data.course_name).toBe(body.course_name);
    expect(data.code).toBe(body.code);
  });

  it('DELETE /api/asignaturas debe fallar si falta course_id', async () => {
    const req = new NextRequest('http://localhost/api/asignaturas');
    const res = await deleteAsignatura(req);
    const data = await res.json();
    expect(res.status).toBe(400);
    expect(data).toHaveProperty('error');
  });
});
