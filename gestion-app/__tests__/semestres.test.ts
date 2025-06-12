import { GET as getSemestres } from '../app/api/semestres/route';

describe('API - Semestres', () => {
  it('GET /api/semestres debe retornar lista de semestres', async () => {
    const res = await getSemestres();
    const data = await res.json();

    expect(Array.isArray(data)).toBe(true);
    expect(data.length).toBeGreaterThan(0);
    expect(data[0]).toHaveProperty('semester_id');
    expect(data[0]).toHaveProperty('semester_num');
    expect(data[0]).toHaveProperty('semester_name');
  });
});
