using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PointLIghtIntensity : MonoBehaviour
{
    public float minIntensity = 0.25f;
    public float maxIntensity = 0.5f;
    public float speed = 2.0f;
    public float offsetX = 0.0f;
    public float lightOffsetMultiplier = 0.0f;
    
    private Light _light;
    private float _seed;
    private Transform _tm;
    private Vector3 _pos;
    private Vector3 _offset;
    
    // Start is called before the first frame update
    void Start()
    {
        _light = GetComponent<Light>();
        _seed = Random.Range(0.0f, 65535.0f);

        _tm = transform;
        _pos = _tm.position;
    }

    // Update is called once per frame
    void Update()
    {
        float noise = Mathf.PerlinNoise(_seed, Time.time * speed);
        
        if (_light != null)
        {
            _light.intensity = Mathf.Lerp(minIntensity, maxIntensity, noise);    
        }

        if (_tm != null)
        {
            _offset.x = noise * lightOffsetMultiplier + offsetX;
            _tm.position = _pos + _offset;    
        }
    }
}