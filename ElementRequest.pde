/**
 * Represents a request that the element can make to the world.
 */
abstract class ElementRequest<T> {
  /**
   * Data that can be used to augment the request.
   */
  public abstract T getData();
}
