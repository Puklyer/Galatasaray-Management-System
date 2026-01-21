// Basit Supabase PostgreSQL bağlantı testi
const { Client } = require('pg');

const connectionString = "postgresql://postgres:5@D1k13a13a.@db.iicxkolmmtptejtdksty.supabase.co:5432/postgres?sslmode=require";

async function testConnection() {
    const client = new Client({
        connectionString: connectionString,
        ssl: {
            rejectUnauthorized: false
        }
    });

    try {
        console.log('🔄 Supabase bağlantısı test ediliyor...');
        
        await client.connect();
        console.log('✅ Supabase bağlantısı başarılı!');
        
        // Basit sorgu testi
        const result = await client.query('SELECT version()');
        console.log('📊 PostgreSQL Version:', result.rows[0].version);
        
        // Mevcut tabloları listele
        const tables = await client.query(`
            SELECT table_name 
            FROM information_schema.tables 
            WHERE table_schema = 'public'
        `);
        
        console.log('📋 Mevcut tablolar:');
        if (tables.rows.length === 0) {
            console.log('   ❌ Hiç tablo bulunamadı!');
        } else {
            tables.rows.forEach(row => {
                console.log(`   ✅ ${row.table_name}`);
            });
        }
        
    } catch (error) {
        console.error('❌ Bağlantı hatası:', error.message);
        console.error('🔍 Detay:', error);
    } finally {
        await client.end();
    }
}

testConnection();